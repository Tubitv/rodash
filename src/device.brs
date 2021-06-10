' /**
'  * @member getDeviceProfile
'  * @memberof module:rodash
'  * @instance
'  * @description
'  *   Get most static information about the device from ifDeviceInfo and ifAppInfo.
'  *   The values included here shouldn't change through the duration of the channel
'  *   running and can be cached.
'  *
'  * @example
'  *
'  * _.getDeviceProfile()
'  * '  => { "deviceInfo": { "model": "4200X", ... } }
'  */
Function rodash_getDeviceProfile_() As Object
  ai = CreateObject("roAppInfo")
  di = CreateObject("roDeviceInfo")

  ' Safe fallback for various unique identifiers
  if FindMemberFunction(di, "GetChannelClientId") <> invalid
    uniqueId = di.GetChannelClientId()
  else if FindMemberFunction(di, "GetPublisherId") <> invalid
    uniqueId = di.GetPublisherId()
  else
    uniqueId = ""
  end if

  if FindMemberFunction(di, "GetRIDA") <> invalid
    adId = di.GetRIDA()
  else
    adId = ""
  end if

  if FindMemberFunction(di, "IsRIDADisabled") <> invalid
    tracking = di.IsRIDADisabled()
  else 
    tracking = false
  end if

  profile =  {
    appInfo: {
      id: ai.GetID()
      version: ai.GetVersion()
      title: ai.GetTitle()
      subtitle: ai.GetSubtitle()
      devid: ai.GetDevID()
      isDev: ai.IsDev()
    }
    deviceInfo: {
      model: di.GetModel()
      modelDetails: di.GetModelDetails()
      modelDisplayName: di.GetModelDisplayName()
      friendlyName: di.GetFriendlyName()
      version: di.GetOSVersion().major + "." + di.GetOSVersion().minor + di.GetOSVersion().build
      uniqueId: uniqueId
      advertisingId: adId
      adTrackingDisabled: tracking
      trackingId: uniqueId
      timeZone: di.GetTimeZone()
      features: {
        "5.1_surround_sound": di.HasFeature("5.1_surround_sound")
        "can_output_5.1_surround_sound": di.HasFeature("can_output_5.1_surround_sound")
        "sd_only_hardware": di.HasFeature("sd_only_hardware")
        "usb_hardware": di.HasFeature("usb_hardware")
        "1080p_hardware": di.HasFeature("1080p_hardware")
        "sdcard_hardware": di.HasFeature("sdcard_hardware")
        "ethernet_hardware": di.HasFeature("ethernet_hardware")
        "gaming_hardware": di.HasFeature("gaming_hardware")
        "bluetooth_hardware": di.HasFeature("bluetooth_hardware")
      }
      locale: di.GetCurrentLocale()
      country: di.GetCountryCode()
      drm: di.GetDrmInfoEx()
      displayType: di.GetDisplayType()
      displayMode: di.GetDisplayMode()
      displayAspectRatio: di.GetDisplayAspectRatio()
      displaySize: di.GetDisplaySize()
      videoMode: di.GetVideoMode()
      displayProperties: di.GetDisplayProperties()
      supportedGraphicsResolutions: di.GetSupportedGraphicsResolutions()
      uiResolution: di.GetUIResolution()
      graphicsPlatform: di.GetGraphicsPlatform()
      videoDecodeInfo: {} 'deprecated
      audioOutputChannel: di.GetAudioOutputChannel()
      audioDecodeInfo: {} 'deprecated
    }
  }
  return profile
End Function
