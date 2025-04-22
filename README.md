# Assembly Learning
This repository is a collection of my notes and learnings throughout the book:
"**Learn to Program with Assembly**" - Jonathan Bartlett

---

# Docker Setup for Linux Assembly Development

This guide explains how to configure a simple environment to write and run **x86-64 Assembly** using Docker, for **macOS**, **Linux**, and **Windows**.

`That's because to run this Assembly code you need to be on a Linux environment !!! 
So you will connect to the Docker image to "make" the files and "execute" them !!!`

---

## 🔧 Requirements

- Internet connection  
- Docker installed (or Colima for macOS)  
- A terminal (bash, WSL, PowerShell)

---

## 🐳 Automatic Setup for macOS / Linux

Before running the setup script, make it executable:

```bash
chmod +x setup.sh
```
Then run the script with:
```bash
./setup.sh
```
---

**setup.sh content:**
```bash
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
```

---

## 🪟 Setup for Windows

### Docker Desktop

1. Download Docker Desktop: https://www.docker.com/products/docker-desktop
2. Install and restart your PC if required.
3. Launch Docker Desktop and make sure it's running.


```bash
docker run -it --rm --mount type=bind,src=$(pwd),target=/my-code johnnyb61820/linux-assembly
```

---

## Useful Commands

- `make` → builds `.s` files into `obj/`, and executables into `exe/`
- `make clean` → removes all generated files


