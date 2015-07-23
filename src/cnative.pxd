__author__ = 'Vash'


from libcpp cimport bool


cdef extern from "cameratypes.h" namespace "CameraLibrary":
    enum eStatusLEDs:

        #== Standard Status LEDs =====------

        GreenStatusLED      = 0x20,
        RedStatusLED        = 0x10,
        CaseStatusLED       = 0x40,
        IlluminationLED     = 0x80,

        #== TIR5 =====================------

        LeftRedStatusLED    = 16,
        LeftGreenStatusLED  = 32,
        RightRedStatusLED   = 1,
        RightGreenStatusLED = 2,

        #== SNAV4 =====================-----

        SNAV4FrontRedStatusLED   = 0x10,
        SNAV4FrontGreenStatusLED = 0x20,
        SNAV4BottomStatusLED     = 0x40,

        #== Prime Series ==============-----

        AimAssistLED             = 0x100



cdef extern from "camera.h" namespace "CameraLibrary":
    cdef cppclass Camera:

        void SetNumeric(bool enable , int value)     #Turn on/off numeric camera LEDs and change the value they show

        void SetLED(eStatusLEDs led, bool enable)    #Turn Camera LEDs On/Off

        void Release()                               #Call this when you're done with a camera



cdef extern from "cameramanager.h" namespace "CameraLibrary::CameraManager":
    cdef CameraManager& X()


cdef extern from "cameramanager.h" namespace "CameraLibrary":
    cdef cppclass CameraManager:

        bool WaitForInitialization()                 #Optional execution stall until cameras are init'd

        bool AreCamerasInitialized()                 #Check and see if all attached cameras are init'd

        void Shutdown()                              #Shutdown Camera Library

        bool AreCamerasShutdown()                    #Check and see if all cameras are shutdown

        Camera * GetCamera()                         #Get a random attached & initialized camera