import { LightningElement } from 'lwc';
import getRandomAdvice from '@salesforce/apex/RandomAdviceService.getRandomAdvice';

export default class RandomAdvice extends LightningElement {
    advice;
    error;
    isLoading = false;

    handleGetAdvice() {
        this.isLoading = true;
        this.error = undefined;
        getRandomAdvice()
            .then((result) => {
                this.advice = result;
            })
            .catch((error) => {
                this.error = error.body ? error.body.message : error.message;
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
