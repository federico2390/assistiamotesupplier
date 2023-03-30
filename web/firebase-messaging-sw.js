importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-messaging-compat.js');

const firebaseConfig = {
    apiKey: "AIzaSyDtvKnfTvIdQiNwSsB8QPKdUnLGEiSnTuQ",
    authDomain: "studio-pa-db402.firebaseapp.com",
    projectId: "studio-pa-db402",
    storageBucket: "studio-pa-db402.appspot.com",
    messagingSenderId: "36780231042",
    appId: "1:36780231042:web:7cce2fb199be2c2e2b679b",
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function (payload) {
    console.log('[firebase-messaging-sw.js] Received background message ', payload);
    const notificationTitle = '';
    const notificationOptions = {
        body: '',
        icon: 'icons/firebase-logo.png'
    };

    self.registration.showNotification(notificationTitle, notificationOptions);
});
