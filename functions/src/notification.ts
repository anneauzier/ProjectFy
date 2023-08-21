/* eslint-disable max-len */
import * as admin from "firebase-admin";

export const pushNotification = async (notification: Notification) => {
  const tokens = await getTokens(notification.targetID);

  const payload = {
    tokens: tokens,
    notification: {
      title: notification.title,
      body: notification.body,
    },
    data: {
      body: notification.body,
    },
  };

  admin.messaging().sendEachForMulticast(payload);
};

interface Notification {
    targetID: string
    title: string
    body: string
}

const getTokens = async (targetID: string): Promise<string[]> => {
  const userFCMTokens = (await admin.firestore().collection("tokens").doc(targetID).get()).data();

  if (userFCMTokens === undefined) {
    console.log("token not found");
    return [];
  }

  return userFCMTokens.tokens;
};


