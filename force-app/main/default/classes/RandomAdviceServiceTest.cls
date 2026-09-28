@IsTest
private class RandomAdviceServiceTest {
    private class AdviceSlipMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"slip":{"id":1,"advice":"Take a deep breath."}}');
            return res;
        }
    }

    private class AdviceSlipErrorMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(500);
            res.setBody('Internal Server Error');
            return res;
        }
    }

    @IsTest
    static void getRandomAdvice_returnsAdviceText_onSuccess() {
        Test.setMock(HttpCalloutMock.class, new AdviceSlipMock());

        Test.startTest();
        String advice = RandomAdviceService.getRandomAdvice();
        Test.stopTest();

        System.assertEquals('Take a deep breath.', advice, 'Expected the advice text parsed from the mocked response body');
    }

    @IsTest
    static void getRandomAdvice_throwsAuraHandledException_onHttpError() {
        Test.setMock(HttpCalloutMock.class, new AdviceSlipErrorMock());

        Boolean exceptionThrown = false;

        Test.startTest();
        try {
            RandomAdviceService.getRandomAdvice();
        } catch (AuraHandledException e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assertEquals(true, exceptionThrown, 'Expected an AuraHandledException when the callout returns a non-200 status');
    }
}
