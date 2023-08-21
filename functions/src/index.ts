/* eslint-disable max-len */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {pushNotification} from "./notification";

admin.initializeApp();

export const notificate = functions.firestore
  .document("/notifications/{notificationID}")
  .onCreate((snapshot) => {
    const notification = snapshot.data();

    return pushNotification({
      targetID: notification.target_id,
      title: notification.title,
      body: notification.body,
    });
  });

export const teste = functions.firestore
  .document("/notifications/{notificationID}")
  .onDelete((snapshot, context) => {
    console.log("apagou", context.params.notificationID);
  });
