# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "SQLiteBuilder"
version = v"0.1.0"

# Collection of sources required to build SQLiteBuilder
sources = [
    "https://www.sqlite.org/2018/sqlite-autoconf-3240000.tar.gz" =>
    "d9d14e88c6fb6d68de9ca0d1f9797477d82fc3aed613558f87ffbdbbc5ceb74a",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd sqlite-autoconf-3240000/
./configure --prefix=$prefix --host=$target && make && make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = BinaryBuilder.supported_platforms()

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libsqlite3", :libsqlite)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

