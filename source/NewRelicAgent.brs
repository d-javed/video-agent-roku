'**********************************************************
' NewRelicAgent.brs
' New Relic Agent for Roku.
' Minimum requirements: FW 7.2
'
' Copyright 2019 New Relic Inc. All Rights Reserved. 
'**********************************************************

function NewRelicStart(account as String, apikey as String) as Void
    print "Init NewRelicAgent" 
    m.nrAccountNumber = account
    m.nrInsightsApiKey = apikey
end function

function nrInsertInsightsData(eventType as String, attributes as Object) as Object
    _url = box("https://insights-collector.newrelic.com/v1/accounts/" + m.nrAccountNumber + "/events")
    _apikey = m.nrInsightsApiKey
    attributes["eventType"] = eventType
    _jsonString = FormatJson(attributes)

    'TODO: it only works in a thread (task)
    _urlReq = CreateObject("roUrlTransfer")

    _urlReq.SetUrl(_url)
    _urlReq.RetainBodyOnError(true)
    _urlReq.EnablePeerVerification(false)
    _urlReq.EnableHostVerification(false)
    _urlReq.AddHeader("Content-Type","application/json")
    _urlReq.AddHeader("X-Insert-Key",_apikey)

    _resp = _urlReq.PostFromString(_jsonString)
    
    return _resp
end function