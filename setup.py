__author__ = 'Vash'

from setuptools import setup, Extension
from Cython.Build import cythonize

native = Extension(
    'cam.native',
    sources=["src\\native.pyx" ],
    include_dirs=["C:\\Program Files (x86)\\OptiTrack\\Camera SDK\\include", "src"],
    library_dirs=["C:\\Program Files (x86)\\OptiTrack\\Camera SDK\\lib"],
    extra_link_args=["/DEFAULTLIB:CameraLibrary2008S"],
    language="c++"
)

setup(
    name="cam",
    ext_modules=cythonize(native),
    packages=["cam"]
)