__author__ = 'Vash'

# means comment from official SDK API ## means comment from me

from libcpp cimport bool


cdef extern from "cameratypes.h" namespace "CameraLibrary":
    cpdef enum eStatusLEDs:

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


    cpdef enum eImagerGain:

        Gain_Level0                  = 0,
        Gain_Level1                  = 1,
        Gain_Level2                  = 2,
        Gain_Level3                  = 3,
        Gain_Level4                  = 4,
        Gain_Level5                  = 5,
        Gain_Level6                  = 6,
        Gain_Level7                  = 7



cdef extern from "camera.h" namespace "CameraLibrary":
    cdef cppclass Camera:

        void        SetNumeric(bool enable , int value)                             #Turn on/off numeric camera LEDs and change the value they show
        void        SetLED(eStatusLEDs led, bool enable)                            #Turn Camera LEDs On/Off. ##Could for example turn off the AimAssistLED blinking at the back of the camera when it is initialized.
        void        SetAllLED(eStatusLEDs led)                                      #Turn all camera LEDs On/Off.
        void        SetStatusIntensity(int intensity)                               #All Status LED to (0-->255). ##So far not sure what that means
        int         StatusRingLightCount()                                          #Number of status ring LEDs ##function is also virtual and also(maybe redefined?) in camerarev26.h and 31 and 33)

        # Ringlight (IR Light) Methods
        bool        RinglightEnabledWhileStopped()                                  ## Should return if the function below is enabled or disabled.
        void        SetRinglightEnabledWhileStopped(bool enable)                    ## If remember correctly, when the cameras are initialized but do not record (i.e. are stopped) one can change intensity of ringlight. Like the IR LEDs below.
        void        SetIntensity(int value)                                         #set camera intensity ##(function is also virtual) Actually changes the value of the intensity for the ring LEDs (so far only IR?)
        int         Intensity()                                                     #get camera intensity ##function is also virtual and also(maybe redefined?)in CameraRev16Child.h)
        int         MinimumIntensity()                                              #Returns the minimum intensity
        int         MaximumIntensity()                                              #Returns the maximum intensity


        void        SetExposure(int value)                                          #Set camera exposure ##In photography, shutter speed or exposure time is the length of time a camera's shutter is open when taking a photograph

        int         Exposure()                                                      #Get Camera Exposure

        int         MinimumExposureValue()                                          #Returns the minimum camera exposure

        int         MaximumExposureValue()                                          #Returns the maximum camera exposure


        void        SetFrameRate(int value)                                         #set camera frame rate (##function is also virtual). For Ethernet devices as well as the OptiTrack Flex 13, when calling SetFrameRate(), the value is the desired frame rate.

        int         FrameRate()                                                     #get camera frame rate ##function is also virtual.

        void        SetFrameDecimation(int value)                                   #set camera frame decimation ##Frame decimation reduces the number of input frames to increase pose and structure robustness in Structure and Motion (SaM) applications

        int         FrameDecimation()                                               #Get Camera Frame Decimation ##function is also virtual

        void        ActualFrameRate()                                               #Current camera frame rate (frames/sec) ##function is also virtual

        int         MinimumFrameRateValue()                                         #returns the minimum frame rate ##function is also virtual

        int         MaximumFrameRateValue()                                         #returns the maximum frame rate ##function is also virtual


        void        SetIRFilter(bool enabled)                                       #Enable/Disable IR Bandpass Filter ##function is also virtual

        bool        IRFilter()                                                      ##probably returns state of IR filter above (function is also virtual)

        bool        IsFilterSwitchAvailable()                                       ##returns false as implemented in camera.h but is virtual and probably camera dependent

        void        SetStrobeOffset(int value)                                      #Set IR Illumination Delay ##(virtual) strobe and illumination delay? So switch the chip on and off? why?

        int         StrobeOffset()                                                  #Get IR Illumination Delay ##virtual


        void        SetAGC(bool enable)                                             #Enable/Disable Imager AGC ##The AutomaticGainControl increases the intensifier gain if the video scene is too dim and decreases the gain if the video scene is too bright

        bool        AGC()                                                           ##probably returns if AGC is on or off (see above)

        bool        IsAGCAvailable()                                                ##returns false as implemented in camera.h but is virtual and probably camera dependent


        void        SetAEC(bool enable)                                             #Enable/Disable Imager AEC ##automatic exposure control

        bool        AEC()                                                           ##returns if AEC is on or off (see above)

        bool        IsAECAvailable()                                                ##returns false as implemented in camera.h but is virtual and probably camera dependent


        void        SetThreshold(int value)                                         #Set Camera Threshold ##the intensity after which a pixel shows a signal ?

        int         Threshold()                                                     #Get Camera Threshold

        int         MinimumThreshold()                                              #Returns the minimum threshold ##virtual

        int         MaximumThreshold()                                              #Returns the maximum threshold ##virtual


        void        SetPrecisionCap(int value)                                      #Set Precision Packet Size Cap ##?

        int         PrecisionCap()                                                  #Get Precision Cap


        void        SetImagerGain(eImagerGain imager_gain)                          #Image gain ##gain in a digital imaging device represents the relationship between the number of electrons acquired on an image sensor and the analog-to-digital units (ADUs) that are generated, representing the image signal. Increasing the gain amplifies the signal by increasing the ratio of ADUs to electrons acquired on the sensor. The result is that increasing gain increases the apparent brightness of an image at a given exposure

        eImagerGain ImagerGain()                                                    ##gives back actual imager gain value (see above)

        int         ImagerGainLevels()                                              ##(virtual) probably gives back number of possible levels starting to count at 0

        bool        IsImagerGainAvailable()                                         ##returns false as implemented in camera.h but is virtual and probably camera dependent


        void Release()                                                              #Call this when you're done with a camera



cdef extern from "cameramanager.h" namespace "CameraLibrary::CameraManager":
    cdef CameraManager& X()


cdef extern from "cameramanager.h" namespace "CameraLibrary":
    cdef cppclass CameraManager:

        bool WaitForInitialization()                 #Optional execution stall until cameras are init'd

        bool AreCamerasInitialized()                 #Check and see if all attached cameras are init'd

        Camera * GetCamera()                         #Get a random attached & initialized camera


        void Shutdown()                              #Shutdown Camera Library

        bool AreCamerasShutdown()                    #Check and see if all cameras are shutdown