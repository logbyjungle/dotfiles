
set -e
clear

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
