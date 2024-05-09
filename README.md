# Use Python version  or 3.10 . Do not use ***Python 3.11 or 3.12***  (Some of the packages used here are not supported in these versions ) .


Here is a step by step procedure of how to run this model.
Step 1: Decide on what platform to train on :
    a. Google Colab : connect the colab file to local runtime 
    b. Run it on Jupyter NoteBook.

Step 2 : Install the required packages 
1. tensorflow
2. keras
3. Keras-Preprocessing
4. opencv-python
5. matplotlib

Step 3: paste the path of the directory in [here] (https://colab.research.google.com/drive/13k7xR29Us1Ha7z-W3UVJME0o32-AvNth#scrollTo=Z6dapaHYn7rt&line=10&uniqifier=1)

Step 4 : run the cells and observe the results

Step 5 : To predict an image , paste the appropriate paths and run the [cell](
Here is the structure showing how dataset should be arranged : 

dataset/
|-- train/
|   |-- input/
|       |-- image1.jpg
|       |-- image2.jpg
|       |-- ...
|   |-- target/
|       |-- image1.jpg
|       |-- image2.jpg
|       |-- ...
|-- val/
|   |-- input/
|       |-- val_image1.jpg
|       |-- val_image2.jpg
|       |-- ...
|   |-- target/
|       |-- val_image1.jpg
|       |-- val_image2.jpg
|       |-- ...


