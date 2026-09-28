import { LightningElement } from 'lwc';
import getRandomAdvice from '@salesforce/apex/RandomAdviceService.getRandomAdvice';

export default class RandomAdvice extends LightningElement {
    advice;
    error;
    isLoading = false;

    handleGetAdvice() {
        this.isLoading = true;
        this.advice = undefined;
        this.error = undefined;

        getRandomAdvice()
            .then((result) => {
                this.advice = result;
            })
            .catch((err) => {
                this.error = err.body?.message || 'Something went wrong while fetching advice.';
            })
            .finally(() => {
                this.isLoading = false;
            });
    }
}
