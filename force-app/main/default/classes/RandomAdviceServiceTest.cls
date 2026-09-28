@isTest
private class RandomAdviceServiceTest {
    private class AdviceMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"slip": { "id": 1, "advice": "Never run with scissors." }}');
            res.setStatusCode(200);
            return res;
        }
    }

    @isTest
    static void testGetRandomAdvice() {
        Test.setMock(HttpCalloutMock.class, new AdviceMock());

        Test.startTest();
        String advice = RandomAdviceService.getRandomAdvice();
        Test.stopTest();

        System.assertEquals('Never run with scissors.', advice);
    }
}
