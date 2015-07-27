# Facial-Expression-Detection
###HOW TO RUN and get expression for a particular image using matlab:

1. Run ann.m to build the neural network. Open the MATLAB command window and execute the following command: ```>> ann.m```

2. Place the image to test in the “sample” folder provided. Open the MATLAB command window and execute the following command: ```>> test()```

This will display the expression and the image, for each image contained in the “sample” folder.

**NOTE**: The below steps require original database folders. But due to moodle upload limit we are not including those. But the database input matrices to the classifier are included in the project.
And they get loaded when the code is executed.
So directly proceed to third step below.

###Steps involved in training the classifier and testing :

1.	Process the database folders (extended-cohn-kanade-images/jaffeimages) and output a folder 'Training_data' containing categorized images in different folders numbered 0 to 6. This is done by running createTrainingData.m. getAllFiles.m is also used in the process, which returns the list of all the files in the argument path. It searches for the files recursively and must be in the same directory as that of createTrainingData.m.

   **createTrainingData.m** : This code creates the Training_data folder which contains the expression categorised files in respective folders from extended cohn-kanade and jaffe databases. For extended cohn-kanade database, make sure Emotion_labels and extended-cohn-kanade-images folder are in the same directory. For jaffe database, jaffeimages folder must be in the same directory. Uncomment the particular database code, and comment the other database's code depending on whose training data you require.

2.	In the second step we rename the ‘Training_data’ to ‘cohn_kanade_train’ or ‘jaffe_train’ depending on the database. Then we create a new folder ‘cohn_kanade_test’ / ‘jaffe_test’ . We remove some of the images (about 15%) from the train folder into this test folder. Now as the data has been organized, we need to generate the input matrix for the classifier. This is done by running preprocess.m

   **preprocess.m** : This function preprocess the images provided in above the folders to create training and testing data matrix for the corresponding databases. The data is saved as jaffe.mat and cohnkanade.mat. The function takes a string as an input parameter - 'cohn' to preprocess the cohn-kanade database and 'jaffe' to preprocess the cohn-kanade database. It uses fetureDetect.m function to detect features from an image.

   **featureDetect.m** : This function takes an image as parameter and returns the LBP histogram for the image from three regions of the face the eye, nose and the mouth. First, it detects the face from the image using the violaJones.m function then it finds the LBP histogram for each of the three regions of the detected face using the lbp.m function and returns the final concatenated histogram of the three region.
   **lbp.m** : lbp(I) returns the LBP histogram (non-normalized) of the imread image I.

3.	Now as the cohnkanade.mat/jaffe.mat are ready, we run the script ann.m, which loads either cohnkanade.mat or jaffe.mat, due to which trainX, trainY, testX and testY are loaded. Train matrices are then used to train the classifier(neural network) by running mlptrain.m. Then mlptest.m is called by the ann.m script, which tests the learned model using the test matrices. 

   **ann.m** : This code trains the artificial neural network using the mlptrain.m  function and then test the trained network using mlptest.m function on some independent images from the corresponding database. The training and testing data are loaded from either “jaffe.mat” or “cohnkanade.mat” file. Uncomment the particular database code, and comment the other database code at line num 5, 6 and 35, 36 depending on whose training and testing data you require.

   **mlptrain.m** : This function takes training data and training parameters hidden layer neurons , learning rate and number of epochs as input and trains a neural network using gradient decent. It returns the weights of the input and hidden layer as output.

   **mlptest.m** : This functions takes weights of the layers of the neural network and testing data points as input and returns the classes of the data as predicted by the network.

   **checkacc.m** : It checks the performance of the neural network by finding the training and test accuracy.

4.	The facial expression for some sample images can be seen by executing the following command in the command window:
```>> test()```

   **test.m** : This function displays the image and its facial expression. It reads the images from the “sample” shows the predicted expression found by the neural network. To find expression of  any other image place it in the “sample” folder and run this function. Uncomment the particular database code, and comment the other database code at line num 3, 4, depending on whose parameters you require.

For Viola Jones implementation to work, make sure violaJones.m, detectFace.m, integralImage.m, calcInstances.m, sumRectangle.m, oneScale.m and TrainData.mat are in the same directory.

   **violaJones.m** : [x,y,height,width] = violaJones(img)
violaJones function takes imread image as the input and returns the coordinates of the top left point, height and width of the detected face window.

   **testViola.m** : testViola(img)
It takes the image path as the input and shows the image with the detected face window.
