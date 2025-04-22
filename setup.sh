#!/bin/bash
set -e

# === Funzione per verificare se un comando esiste ===
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# === Verifica se sei dentro un container ===
if grep -qE "/docker|/lxc" /proc/1/cgroup 2>/dev/null; then
    echo "Questo script non può essere eseguito dentro un container Docker o LXC."
    exit 1
fi

# === Sistema operativo e architettura ===
OS=$(uname -s)
ARCH=$(uname -m)

echo "🖥️  Sistema operativo rilevato: $OS ($ARCH)"

# === curl (solo Linux) ===
if [ "$OS" = "Linux" ] && ! command_exists curl; then
    echo "curl non trovato. Installazione in corso..."
    apt update && apt install -y curl
fi

# === macOS: solo Colima + docker CLI ===
if [ "$OS" = "Darwin" ]; then
    # Docker CLI (no Docker Desktop)
    if ! command_exists docker; then
        echo "Docker CLI non trovato. Installazione in corso..."
        if command_exists brew; then
            brew install docker
        else
            echo "Homebrew non trovato. Installalo prima di continuare."
            exit 1
        fi
    else
        echo "Docker CLI già installato."
    fi

    # Colima
    if ! command_exists colima; then
        echo "Colima non trovato. Installazione in corso..."
        brew install colima
    else
        echo "Colima già installato."
    fi

    # Avvio Colima
    if ! colima status | grep -q "Running"; then
        echo "Avvio Colima..."
        colima start
    else
        echo "Colima è già in esecuzione."
    fi
fi

# === Linux: Docker completo ===
if [ "$OS" = "Linux" ] && ! command_exists docker; then
    echo "Docker non trovato. Installazione in corso..."
    curl -fsSL https://get.docker.com | sh
else
    echo "Docker già installato."
fi

# === Verifica che Docker sia attivo ===
if ! docker info >/dev/null 2>&1; then
    echo "Docker è installato ma non è in esecuzione."

    if [ "$OS" = "Linux" ]; then
        echo "Prova ad avviarlo con: dockerd &"
    elif [ "$OS" = "Darwin" ]; then
        echo "Verifica che Colima sia attivo oppure riavvialo con: colima start"
    fi

    exit 1
fi

# === Esecuzione del container ===
echo "Esecuzione del container Docker..."
docker run -it --rm --mount type=bind,src="$(pwd)",target=/my-code johnnyb61820/linux-assembly