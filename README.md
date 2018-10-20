# dev.akademi2018
### Sahibinden Yazilim Maratoni 2018

This project aims to solve the problem of "How much should I bid on for the best effective result with my budget on a specific category"

2 different modals are developed on R.

First approach is to use linear discrimination to find W and w0. Because the data set is huge and I could not find an optimal learning rate (eta), this didn't finish on training.
So, first part of the code is trying to do this. 

Second approach is to use multivariate linear regression to find the same thing. This is the current working model.

### To run, 
Go to the directory and run the script

rscript --vanilla ml_experiment.R arg1 arg2;

First argument: Your total budget
Second argument: Category (from this set: 'İkinci El ve Sıfır Alışveriş', 'Emlak', 'Vasıta', 'Yedek Parça, Aksesuar, Donanım & Tuning', 'İş Makineleri & Sanayi', 'Hayvanlar Alemi')


