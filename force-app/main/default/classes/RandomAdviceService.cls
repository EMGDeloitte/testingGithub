public with sharing class RandomAdviceService {
    private static final String ADVICE_API_ENDPOINT = 'https://api.adviceslip.com/advice';

    @AuraEnabled
    public static String getRandomAdvice() {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ADVICE_API_ENDPOINT);
        req.setMethod('GET');
        req.setTimeout(10000);

        Http http = new Http();
        HttpResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            throw new AuraHandledException('Failed to retrieve advice: HTTP ' + res.getStatusCode());
        }

        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        Map<String, Object> slip = (Map<String, Object>) result.get('slip');
        return (String) slip.get('advice');
    }
}
