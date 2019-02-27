'**********************************************************
' NRUtils.brs
' New Relic Agent Utility functions for Roku.
' Minimum requirements: FW 7.2
'
' Copyright 2019 New Relic Inc. All Rights Reserved. 
'**********************************************************

function nrInsertInsightsData(eventType as String, attributes as Object) as Object
    _url = box("https://insights-collector.newrelic.com/v1/accounts/" + m.global.nrAccountNumber + "/events")
    _apikey = m.global.nrInsightsApiKey
    attributes["eventType"] = eventType
    _jsonString = FormatJson(attributes)

    _urlReq = CreateObject("roUrlTransfer")

    _urlReq.SetUrl(_url)
    _urlReq.RetainBodyOnError(true)
    _urlReq.EnablePeerVerification(false)
    _urlReq.EnableHostVerification(false)
    _urlReq.AddHeader("Content-Type","application/json")
    _urlReq.AddHeader("X-Insert-Key",_apikey)

    _resp = _urlReq.PostFromString(_jsonString)
    
    print "------"
    print _jsonString
    print "------"
    
    return _resp
end function