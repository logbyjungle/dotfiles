set -e
clear
#!/bin/bash

if [ -f main.cpp ] && [ ! -f main.py ]; then
    if [ ! -f .clangd ]; then
        curl -L https://raw.githubusercontent.com/logbyjungle/dotfiles/main/.clangd -o .clangd
        echo "Downloaded .clangd successfully."
    fi

    if [ ! -f CMakeLists.txt ]; then
        curl -L https://raw.githubusercontent.com/logbyjungle/dotfiles/main/CMakeLists.txt -o CMakeLists.txt
        echo "Downloaded CMakeLists.txt successfully."
    fi

    if [ ! -f .clang-tidy ]; then
        curl -L https://raw.githubusercontent.com/logbyjungle/dotfiles/main/.clang-tidy -o .clang-tidy
        echo "Downloaded .clang-tidy successfully."
    fi

    if [ ! -d build ]; then
        mkdir build
        echo "Build directory created successfully."
    fi

    cd build/
    cmake ..
    cd ..

    start=$(date +%s%N)
    cmake --build build
    end=$(date +%s%N)
    echo "Compile time: $(((end - start) / 1000000)) ms"

    start=$(date +%s%N)
    ./build/main
    end=$(date +%s%N)
    echo "Run time: $(((end - start) / 1000000)) ms"

    gprof ./build/main gmon.out | c++filt > result.txt
    exit 0
fi

if [ -f main.py ] && [ ! -f main.cpp ]; then
    if [ ! -d "venv" ]; then
        echo "creating venv"
        python3 -m venv venv
    fi

    source venv/bin/activate


    start=$(date +%s%N)
    venv/bin/python main.py
    end=$(date +%s%N)
    echo "Run time: $(((end - start) / 1000000)) ms"
    exit 0
fi

if [ -f main.py ] && [ -f main.cpp ]; then
    echo found both main.py and main.cpp , executing none
    exit 0
fi

echo found no main file
