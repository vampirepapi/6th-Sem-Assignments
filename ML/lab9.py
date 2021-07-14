import sklearn 

import pandas as pd

from sklearn.datasets import load_iris

iris=load_iris()

iris.keys()

df=pd.DataFrame(iris['data'])

print(df)

print(iris['target_names'])

iris['feature_names']


X=df

y=iris['target']



from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)


from sklearn.neighbors import KNeighborsClassifier

knn=KNeighborsClassifier(n_neighbors=3)

knn.fit(X_train,y_train)

import numpy as np

x_new=np.array([[5,2.9,1,0.2]])


prediction=knn.predict(x_new)

iris['target_names'][prediction]


from sklearn.metrics import confusion_matrix

from sklearn.metrics import accuracy_score

from sklearn.metrics import classification_report

y_pred=knn.predict(X_test)

cm=confusion_matrix(y_test,y_pred) 

print(cm)

print(" correct predicition",accuracy_score(y_test,y_pred))

print(" worng predicition",(1-accuracy_score(y_test,y_pred)))