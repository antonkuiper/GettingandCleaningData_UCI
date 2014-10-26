Code Book
========

Raw data collection
-------------------

### Collection

Raw data are obtained from UCI Machine Learning repository. In particular we used
the *Human Activity Recognition Using Smartphones Data Set* [[1](#uci-har)],
that was used by the original collectors to conduct experiments exploiting
Support Vector Machine (SVM) [[2](#har-smart)].

Activity Recognition (AR) aims to recognize the actions and goals of one or more agents
from a series of observations on the agents' actions and the environmental conditions
[[3](#activity-recognition)]. The collectors used a sensor based approach employing
smartphones as sensing tools. Smartphones are an effective solution for AR, because
they come with embedded built-in sensors such as microphones, dual cameras, accelerometers,
gyroscopes, etc.

The data set was built from experiments carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six activities
(walking, walking upstairs, walking downstairs, sitting, standing, laying)
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded
accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity
were captured at a constant rate of 50Hz. The experiments have been video-recorded
to label the data manually [[4](#har-smart2)].

The obtained data set has been randomly partitioned into two sets, where 70% of
the volunteers was selected for generating the training data and 30% the test data.

### Signals

The 3-axial time domain [[5](#time-domain)] signals from accelerometer and gyroscope
were captured at a constant rate of 50 Hz [[6](#hertz)]. Then they were filtered
to remove noise.
Similarly, the acceleration signal was then separated into body and gravity
acceleration signals using another filter.
Subsequently, the body linear acceleration and angular velocity were derived in time
to obtain Jerk signals [[7](#jerk)]. Also the magnitude [[8](#magnitude)] of these
three-dimensional signals were calculated using the Euclidean norm [[9](#euclidean-norm)]. 
Finally a Fast Fourier Transform (FFT) [[10](#fft)] was applied to some of these
time domain signals to obtain frequency domain [[11](#freq-domain)] signals.

The signals were sampled in fixed-width sliding windows of 2.56 sec and 50% 
overlap (128 readings/window at 50 Hz).
From each window, a vector of features was obtained by calculating variables
from the time and frequency domain.

The set of variables that were estimated from these signals are: 

*  mean(): Mean value
*  std(): Standard deviation
*  mad(): Median absolute deviation 
*  max(): Largest value in array
*  min(): Smallest value in array
*  sma(): Signal magnitude area
*  energy(): Energy measure. Sum of the squares divided by the number of values. 
*  iqr(): Interquartile range 
*  entropy(): Signal entropy
*  arCoeff(): Autoregression coefficients with Burg order equal to 4
*  correlation(): Correlation coefficient between two signals
*  maxInds(): Index of the frequency component with largest magnitude
*  meanFreq(): Weighted average of the frequency components to obtain a mean frequency
*  skewness(): Skewness of the frequency domain signal 
*  kurtosis(): Kurtosis of the frequency domain signal 
*  bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT
   of each window.
*  angle(): Angle between some vectors.

No unit of measures is reported as all features were normalized and bounded
within [-1,1].

Data transformation
-------------------

The raw data sets are processed with run_analisys.R script to create a tidy data
set [[12](#tidy-dataset)].

### Merge training and test sets

Test and training data (X_test.txt (raw data of all kind of measures ; y_test.txt 
(derived result ) ; subject_test.txt  (subject (person) who was measured) and  X_train.txt ; y_train.txt and subject_train.txt   are 
merged to obtain a single data set. The structure of the files are identical, so the merge is rather easy. 
Variables are labelled with the names assigned by original collectors (features.txt).


### Extract mean and standard deviation variables

From the merged data set is extracted and intermediate data set with only the
values of estimated mean (variables with labels that contain "mean") and standard
deviation (variables with labels that contain "std").

### Use descriptive activity names

A new column is added to intermediate data set with the activity description.
Activity id column is used to look up descriptions in activity_labels.txt.

### Label variables appropriately

Labels given from the original collectors were changed:
* to obtain valid R names without parentheses, dashes and commas
* to obtain more descriptive labels

### Create a tidy data set

From the intermediate data set is created a final tidy data set where numeric
variables are averaged for each activity and each subject.

The tidy data set contains 180 observations with 88 variables divided in:
*	 per subject (1:30); per activity  (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
   the average  is calculated for all the -mean and -Std variables.
   tbodyaccmeanx	tbodyaccmeany	tbodyaccmeanz	tbodyaccstdx	tbodyaccstdy	tbodyaccstdz	tgravityaccmeanx	
   tgravityaccmeany	tgravityaccmeanz	tgravityaccstdx	tgravityaccstdy	tgravityaccstdz	tbodyaccjerkmeanx	
   tbodyaccjerkmeany	tbodyaccjerkmeanz	tbodyaccjerkstdx	tbodyaccjerkstdy	tbodyaccjerkstdz	tbodygyromeanx	
   tbodygyromeany	tbodygyromeanz	tbodygyrostdx	tbodygyrostdy	tbodygyrostdz	tbodygyrojerkmeanx	tbodygyrojerkmeany	
   tbodygyrojerkmeanz	tbodygyrojerkstdx	tbodygyrojerkstdy	tbodygyrojerkstdz	tbodyaccmagmean	tbodyaccmagstd	
   tgravityaccmagmean	tgravityaccmagstd	tbodyaccjerkmagmean	tbodyaccjerkmagstd	tbodygyromagmean	tbodygyromagstd	
   tbodygyrojerkmagmean	tbodygyrojerkmagstd	fbodyaccmeanx	fbodyaccmeany	fbodyaccmeanz	fbodyaccstdx	fbodyaccstdy
   fbodyaccstdz	fbodyaccmeanfreqx	fbodyaccmeanfreqy	fbodyaccmeanfreqz	fbodyaccjerkmeanx	fbodyaccjerkmeany	
   fbodyaccjerkmeanz	fbodyaccjerkstdx	fbodyaccjerkstdy	fbodyaccjerkstdz	fbodyaccjerkmeanfreqx	fbodyaccjerkmeanfreqy
   fbodyaccjerkmeanfreqz	fbodygyromeanx	fbodygyromeany	fbodygyromeanz	fbodygyrostdx	fbodygyrostdy	fbodygyrostdz	
   fbodygyromeanfreqx	fbodygyromeanfreqy	fbodygyromeanfreqz	fbodyaccmagmean	fbodyaccmagstd	fbodyaccmagmeanfreq	
   fbodybodyaccjerkmagmean	fbodybodyaccjerkmagstd	fbodybodyaccjerkmagmeanfreq	fbodybodygyromagmean	fbodybodygyromagstd	
   fbodybodygyromagmeanfreq	fbodybodygyrojerkmagmean	fbodybodygyrojerkmagstd	fbodybodygyrojerkmagmeanfreq	
   angletbodyaccmean,gravity	angletbodyaccjerkmean,gravitymean	angletbodygyromean,gravitymean	angletbodygyrojerkmean,gravitymean	
   anglex,gravitymean	angley,gravitymean	anglez,gravitymean
   	
For variables derived from mean and standard deviation estimation, the previous labels
are augmented with the terms "Mean" or "StandardDeviation".

The data set is written to the file "UCI_tidy_data_set.txt".

References
----------

1. Human Activity Recognition Using Smartphones Data Set.
   URL: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. 
2. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
   *Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine*.
   International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
3. Activity recognition. URL: <http://en.wikipedia.org/wiki/Activity_recognition>.
4. Fast Fourier transform. URL: <http://en.wikipedia.org/wiki/Fast_Fourier_Transform>.
5. [R] gsub . URL: http://www.endmemo.com/program/R/gsub.php
6. Tidy data set. URL: <https://github.com/jtleek/datasharing#the-tidy-data-set>.
7. Merging of data <http://www.statmethods.net/management/merging.html>

