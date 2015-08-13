# camerapy: The cython optitrack python wrapper project

In this project we wrapped some functionality from the OptiTrack Camera SDK
in Python code. So to say creating a Python API from a C++ API.
We did this using Cython.

To run our code we recommend to first download and install the OptiTrack SDK.
Then install the Microsoft visual C++ compiler package for python 2.7, 
then install Python 2.7.9 and add the following file adresses (or depending
where you installed stuff) to the PATH variable:

C:\Program Files (x86)\OptiTrack\Camera SDK\lib;C:\Python27\;C:\Python27\Scripts\

Then open a console, write pip install cython and hit enter.


To import the wrapped functionality into python, simply cd into your camerapy
folder, write python, hit enter, write import cam.native and hit enter.

After you changed code, cd into your camerapy folder, write python setup.py build_ext --inplace 
and hit enter (if you receive an error message about a dll missing, simply download that dll and
copy it into the System32 folder).

Njoy!
