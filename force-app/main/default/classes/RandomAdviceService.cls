public with sharing class RandomAdviceService {
    @AuraEnabled
    public static String getRandomAdvice() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.adviceslip.com/advice');
        req.setMethod('GET');

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            throw new AuraHandledException('Advice service returned status ' + res.getStatusCode());
        }

        Map<String, Object> parsed = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        Map<String, Object> slip = (Map<String, Object>) parsed.get('slip');
        return (String) slip.get('advice');
    }
}
