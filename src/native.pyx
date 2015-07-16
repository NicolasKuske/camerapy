__author__ = 'Vash'


include "cnative.pxd"


cdef class PyCamM:
    cdef CameraManager *thisptr      # hold a C++ instance which we're wrapping

    def __cinit__(self):
        self.thisptr = &X()

    def wait_init(self):             #Optional execution stall until cameras are init'd
        return self.thisptr.WaitForInitialization()


cdef Camera * thissptr

thissptr=GetCamera()

def set_light(self, enabled, value):
    thissptr.SetNumeric(enabled, value)
    print "lights set"

#doesnt work like this because thissptr is a
#python object or so. I think I read solution in
#cython doc. Also look at the camera control doc.
