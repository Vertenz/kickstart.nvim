#!/bin/bash

# Прерывать выполнение при ошибках
set -e

# Путь к лог-файлу
LOG_FILE="${HOME}/install_neovim.log"

# Перенаправляем весь вывод в лог-файл
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Лог выполнения записывается в: $LOG_FILE"
echo "=== Начало установки: $(date) ==="

# Функция для проверки и установки пакетов на Ubuntu
install_ubuntu() {
    echo "Обновление списка пакетов..."
    sudo apt update

    echo "Установка базовых утилит: git, make, unzip, C Compiler (gcc)..."
    sudo apt install -y git make unzip gcc build-essential

    echo "Установка Ripgrep..."
    sudo apt install -y ripgrep

    echo "Установка утилит для работы с буфером обмена..."
    if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
        echo "Установка xclip для X11..."
        sudo apt install -y xclip
    elif [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        echo "Установка wl-clipboard для Wayland..."
        sudo apt install -y wl-clipboard
    else
        echo "Неизвестная среда, попробуем установить xclip как универсальный инструмент."
        sudo apt install -y xclip
    fi

    echo "Установка Neovim..."
    sudo add-apt-repository -y ppa:neovim-ppa/stable
    sudo apt update
    sudo apt install -y neovim
}

# Функция для проверки и установки пакетов на macOS
install_macos() {
    echo "Проверка наличия Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew не установлен. Устанавливаем Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "Установка базовых утилит: git, make, unzip, gcc..."
    brew install git make unzip gcc

    echo "Установка Ripgrep..."
    brew install ripgrep

    echo "Установка утилит для работы с буфером обмена..."
    brew install xclip wl-clipboard

    echo "Установка Neovim..."
    brew install neovim
}

# Определение операционной системы и установка соответствующих зависимостей
if [[ "$(uname)" == "Darwin" ]]; then
    echo "Обнаружена macOS. Используем Homebrew для установки зависимостей."
    install_macos
elif [[ "$(uname)" == "Linux" ]]; then
    echo "Обнаружена Linux. Используем apt для установки зависимостей."
    install_ubuntu
else
    echo "Не поддерживаемая операционная система. Прерывание."
    exit 1
fi

echo "Проверка установленной версии Neovim..."
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -n 1 | awk '{print $2}')
    REQUIRED_VERSION="0.9.0"
    if dpkg --compare-versions "$NVIM_VERSION" "ge" "$REQUIRED_VERSION"; then
        echo "Установлена версия Neovim: $NVIM_VERSION. Она удовлетворяет требованиям (>= $REQUIRED_VERSION)."
    else
        echo "Установлена версия Neovim: $NVIM_VERSION. Она НЕ удовлетворяет требованиям (>= $REQUIRED_VERSION)."
        echo "Прерывание установки."
        exit 1
    fi
else
    echo "Neovim не найден после установки. Прерывание."
    exit 1
fi

echo "Установка Python и pip..."
if [[ "$(uname)" == "Linux" ]]; then
    sudo apt install -y python3 python3-pip
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install python
fi
pip3 install pynvim

echo "Установка Node.js и npm..."
if ! command -v node &> /dev/null || ! command -v npm &> /dev/null; then
    if [[ "$(uname)" == "Linux" ]]; then
        curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt install -y nodejs
    elif [[ "$(uname)" == "Darwin" ]]; then
        brew install node
    fi
    npm install -g neovim
else
    echo "Node.js и npm уже установлены."
    npm install -g neovim
fi

echo "Установка Ruby и bundler..."
if [[ "$(uname)" == "Linux" ]]; then
    sudo apt install -y ruby-full
elif [[ "$(uname)" == "Darwin" ]]; then
    brew install ruby
fi
sudo gem install bundler neovim

echo "Установка шрифта Nerd Font..."
NERD_FONT_DIR="${HOME}/.local/share/fonts"
mkdir -p "$NERD_FONT_DIR"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
FONT_ZIP="${NERD_FONT_DIR}/JetBrainsMono.zip"
wget -q --show-progress "$FONT_URL" -O "$FONT_ZIP"
unzip -o "$FONT_ZIP" -d "$NERD_FONT_DIR"
fc-cache -fv
rm "$FONT_ZIP"

echo "Клонирование репозитория kickstart.nvim..."
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

if [ -d "$CONFIG_DIR" ]; then
    echo "Каталог $CONFIG_DIR уже существует. Удаляем его..."
    if rm -rf "$CONFIG_DIR"; then
        echo "Каталог $CONFIG_DIR успешно удалён."
    else
        echo "Ошибка при удалении каталога $CONFIG_DIR. Прерывание."
        exit 1
    fi
fi

echo "Клонируем репозиторий..."
if git clone https://github.com/vertenz/kickstart.nvim.git "$CONFIG_DIR"; then
    echo "Репозиторий успешно клонирован в $CONFIG_DIR."
else
    echo "Ошибка при клонировании репозитория. Прерывание."
    exit 1
fi

echo "Установка завершена успешно!"
echo "=== Установка завершена: $(date) ==="
