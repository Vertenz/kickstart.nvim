#!/bin/bash

# Прерывать выполнение при ошибках
set -e

# Путь к лог-файлу
LOG_FILE="${HOME}/install_neovim.log"

# Перенаправляем весь вывод в лог-файл
exec > >(tee -a "$LOG_FILE") 2>&1

echo "Лог выполнения записывается в: $LOG_FILE"
echo "=== Начало установки: $(date) ==="

echo "Обновление списка пакетов..."
sudo apt update

echo "Проверка и установка git..."
if ! command -v git &> /dev/null; then
    echo "Git не установлен. Устанавливаем git..."
    sudo apt install -y git
else
    echo "Git уже установлен."
fi

echo "Установка software-properties-common..."
sudo apt install -y software-properties-common

echo "Добавление PPA репозитория для Neovim..."
sudo add-apt-repository -y ppa:neovim-ppa/stable

echo "Обновление списка пакетов после добавления репозитория..."
sudo apt update

echo "Установка Neovim..."
sudo apt install -y neovim

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
