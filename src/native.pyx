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

#    def get_a_cam(self):              #Get a random attached & initialized camera
 #       return self.thisptr.GetCamera()


cdef class PyCam:
    cdef Camera * thissptr           # hold a C++ instance which we're wrapping

    def __cinit__(self):
        self.thissptr = new Camera()

    def set_light(self, enabled, value):  #Turn on/off numeric camera LEDs
        self.thissptr.SetNumeric(enabled, value)
        print "lights set"

    def releasecam(self):     #Call this when you're done with a camera
        self.thissptr.Release()
        print "camera released"



