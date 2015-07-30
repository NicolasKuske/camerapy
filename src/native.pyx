__author__ = 'Vash'

# means comment from official SDK API (or Cython page) ## means comment from me

include "cnative.pxd"


cdef class PyCamM:
    cdef CameraManager *thisptr            # hold a C++ instance which we're wrapping

    def __cinit__(self):
        self.thisptr = &X()

    def wait_for_initialization(self):     #Optional execution stall until cameras are init'd
        return self.thisptr.WaitForInitialization()

    def are_cameras_initialized(self):     #Check and see if all attached cameras are init'd
        return self.are_cameras_initialized()

    def get_camera(self):                  #Get a random attached & initialized camera
        cam = PyCam()
        cam.thisptr = self.thisptr.GetCamera()
        return cam


    def shutdown(self):                    #Shutdown Camera Library
        return self.thisptr.Shutdown()

    def are_cameras_shutdown(self):        #Check and see if all cameras are shutdown
        return self.thisptr.AreCamerasShutdown()
   # def get_cam(self):
    #    return PyCam(Camera *self.thisptr.GetCamera())


# http://stackoverflow.com/questions/10436837/cython-and-c-class-constructors?lq=1


cdef class PyCam:
    cdef Camera *thisptr                                   #hold a C++ instance which we're wrapping

#    def __cinit__(self, Camera& thisptr):
 #     self.thisptr = thisptr

    def __cinit__(self):
        self.thisptr = NULL

    def set_numeric(self, enable, value):
        """Turn on/off numeric camera LEDs and change the value they show"""
        self.thisptr.SetNumeric(enable , value)

    def set_led(self, led, enable):                        #Turn Camera LEDs On/Off. Could for example turn off the AimAssistLED blinking at the back of the camera when it is initialized.
        self.thisptr.SetLED(led, enable)

    def set_all_led(self, led):
        """Turn all camera LEDs On/Off."""
        self.thisptr.SetAllLED(led)

    def set_status_intensity(self, intensity):             #All Status LED to (0-->255). ##So far not sure what that means
        self.thisptr.SetStatusIntensity(intensity)

    def status_ring_light_count(self):                     #Number of status ring LEDs ##function is also (maybe redefined?) in camerarev26.h and 31 and 33.
        return self.thisptr.StatusRingLightCount()


    def ringlight_enabled_while_stopped(self):             ##returns if the function below is enabled or disabled.
        return self.thisptr.RinglightEnabledWhileStopped()

    def set_ringlight_enabled_while_stopped(self,enable):  ## When the camera is initialized but does not record (i.e. is stopped) one can change intensity of ringlight. Like the IR LEDs below.
        self.thisptr.SetRinglightEnabledWhileStopped(enable)

    def set_intensity(self, value):                        #set camera intensity ##Actually changes the value of the intensity for the ring LEDs (so far only IR?)
        assert self.minimum_intensity() < value < self.maximum_intensity(), "Intensity Values for IR LEDs must be in range {}-{}".format(
                                                                            self.minimum_intensity(), self.maximum_intensity())
        self.thisptr.SetIntensity(value)

    def intensity(self):                                   #get camera intensity ##function is also virtual and also(maybe redefined?)in CameraRev16Child.h)
        return self.thisptr.Intensity()

    def minimum_intensity(self):                           #Returns the minimum intensity
        return self.thisptr.MinimumIntensity()

    def maximum_intensity(self):                           #Returns the maximum intensity
        return self.thisptr.MaximumIntensity()


    def set_exposure(self, value):                         #Set camera exposure ##In photography, shutter speed or exposure time is the length of time a camera's shutter is open when taking a photograph
        self.thisptr.SetExposure(value)

    def exposure(self):                                    #Get Camera Exposure
        return self.thisptr.Exposure()

    def minimum_exposure_value(self):                      #Returns the minimum camera exposure
        return self.thisptr.MinimumExposureValue()

    def maximum_exposure_value(self):                      #Returns the maximum camera exposure
        return self.thisptr.MaximumExposureValue()


    def set_frame_rate(self, value):                       #set camera frame rate (##function is also virtual). For Ethernet devices as well as the OptiTrack Flex 13, when calling SetFrameRate(), the value is the desired frame rate.
        self.thisptr.SetFrameRate(value)

    def frame_rate(self):                                  #get camera frame rate (##function is also virtual)
        return self.thisptr.FrameRate()

    def set_frame_decimation(self, value):                 #set camera frame decimation ##Frame decimation reduces the number of input frames to increase pose and structure robustness in Structure and Motion (SaM) applications
        self.thisptr.SetFrameDecimation(value)

    def frame_decimation(self):                            #Get Camera Frame Decimation (##function is also virtual)
        return self.thisptr.FrameDecimation()

    def actual_frame_rate(self):                           #Current camera frame rate (frames/sec) ##function is also virtual
        return self.thisptr.ActualFrameRate()

    def minimum_frame_rate_value(self):                    #returns the minimum frame rate ##function is also virtual
        return self.thisptr.MinimumFrameRateValue()

    def maximum_frame_rate_value(self):                    #returns the maximum frame rate ##function is also virtual
        return self.thisptr.MaximumFrameRateValue()


    def set_ir_filter(self, enabled):                      #Enable/Disable IR Bandpass Filter ##function is also virtual
        assert self.is_filter_switch_available(), "This camera has no filter switch. You cannot set the IR filter!"
        self.thisptr.SetIRFilter(enabled)

    def ir_filter(self):                                   ##probably returns state of IR filter above (function is also virtual)
        return self.thisptr.IRFilter()

    def is_filter_switch_available(self):                  ##returns false as implemented in camera.h but is virtual and probably camera dependent
        return self.thisptr.IsFilterSwitchAvailable()

    def set_strobe_offset(self, value):                    #Set IR Illumination Delay ##(virtual) strobe and illumination delay? So switch the chip on and off? why?
        self.thisptr.SetStrobeOffset(value)

    def strobe_offset(self):                               #Get IR Illumination Delay ##virtual
        return self.thisptr.StrobeOffset()


    def set_agc(self, enable):                             #Enable/Disable Imager AGC ##The AutomaticGainControl increases the intensifier gain if the video scene is too dim and decreases the gain if the video scene is too bright
        assert self.is_agc_available(), "Cannot set AGC (Automatic Gain Control) for this camera, as is not available."
        self.thisptr.SetAGC(enable)

    def agc(self):                                         ##probably returns if AGC is on or off (see above)
        return self.thisptr.AGC()

    def is_agc_available(self):                            ##returns false as implemented in camera.h but is virtual and probably camera dependent
        return self.thisptr.IsAGCAvailable()


    def set_aec(self, enable):                             #Enable/Disable Imager AEC ##automatic exposure control
        self.thisptr.SetAEC(enable)

    def aec(self):                                         ##returns if AEC is on or off (see above)
        return self.thisptr.AEC()

    def is_aec_available(self):                            ##returns false as implemented in camera.h but is virtual and probably camera dependent
        return self.thisptr.IsAECAvailable()


    def set_threshold(self, value):                        #Set Camera Threshold ##the intensity after which a pixel shows a signal ?
        self.thisptr.SetThreshold(value)

    def threshold(self):                                   #Get Camera Threshold
        return self.thisptr.Threshold()

    def minimum_threshold(self):                           #Returns the minimum threshold ##virtual
        return self.thisptr.MinimumThreshold()

    def maximum_threshold(self):                           #Returns the maximum threshold ##virtual
        return self.thisptr.MaximumThreshold()


    def set_precision_cap(self,value):                     #Set Precision Packet Size Cap ##?
        self.thisptr.SetPrecisionCap(value)

    def precision_cap(self):                               #Get Precision Cap
        return self.thisptr.PrecisionCap()


    def set_imager_gain(self, imager_gain):                #Image gain ##gain in a digital imaging device represents the relationship between the number of electrons acquired on an image sensor and the analog-to-digital units (ADUs) that are generated, representing the image signal. Increasing the gain amplifies the signal by increasing the ratio of ADUs to electrons acquired on the sensor. The result is that increasing gain increases the apparent brightness of an image at a given exposure
        self.thisptr.SetImagerGain(imager_gain)

    def imager_gain(self):                                 ##gives back actual imager gain value (see above)
        return self.thisptr.ImagerGain()

    def imager_gain_levels(self):                          ##(virtual) probably gives back number of possible levels starting to count at 0
        return self.thisptr.ImagerGainLevels()

    def is_imager_gain_available(self):                    ##returns false as implemented in camera.h but is virtual and probably camera dependent
        return self.thisptr.IsImagerGainAvailable()


    def releasecam(self):                                  #Call this when you're done with a camera
        self.thisptr.Release()
        print "camera released"




