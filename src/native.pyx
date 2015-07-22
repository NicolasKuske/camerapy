__author__ = 'Vash'


include "cnative.pxd"


cdef class PyCamM:
    cdef CameraManager *thisptr      # hold a C++ instance which we're wrapping

    def __cinit__(self):
        self.thisptr = &X()

    def wait_init(self):             #Optional execution stall until cameras are init'd
        return self.thisptr.WaitForInitialization()

    def shut_down(self):              #Shutdown Camera Library
        return self.thisptr.Shutdown()

    def are_cameras_down(self):       #Check and see if all cameras are shutdown
        return self.thisptr.AreCamerasShutdown()

    def get_a_cam(self):              #Get a random attached & initialized camera
        cam = PyCam()
        cam.thisptr = self.thisptr.GetCamera()
        return cam

   # def get_cam(self):
    #    return PyCam(Camera *self.thisptr.GetCamera())


# http://stackoverflow.com/questions/10436837/cython-and-c-class-constructors?lq=1


cdef class PyCam:
    cdef Camera *thisptr           # hold a C++ instance which we're wrapping

#    def __cinit__(self, Camera& thisptr):
 #     self.thisptr = thisptr

    def __cinit__(self):
        self.thisptr = NULL

    def set_light(self, enabled, value):  #Turn on/off numeric camera LEDs
        self.thisptr.SetNumeric(enabled, value)
        print "lights set"

    def releasecam(self):     #Call this when you're done with a camera
        self.thisptr.Release()
        print "camera released"



