__author__ = 'Vash'


from libcpp cimport bool


cdef extern from "camera.h" namespace "CameraLibrary":
    cdef cppclass Camera:

        Camera() except +

        void SetNumeric(bool enabled , int value) #Turn on/off numeric camera LEDs

        void Release()              #Call this when you're done with a camera



cdef extern from "cameramanager.h" namespace "CameraLibrary::CameraManager":
    cdef CameraManager& X()


cdef extern from "cameramanager.h" namespace "CameraLibrary":
    cdef cppclass CameraManager:

        bool WaitForInitialization() #Optional execution stall until cameras are init'd

        bool AreCamerasInitialized() #Check and see if all attached cameras are init'd

        void Shutdown()              #Shutdown Camera Library

        bool AreCamerasShutdown()    #Check and see if all cameras are shutdown

        Camera * GetCamera()         #Get a random attached & initialized camera