importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-messaging-compat.js');

const firebaseConfig = {
    apiKey: "AIzaSyBayHY-nuExF9pS84mA50A9nx5Y7zEoUAE",
    authDomain: "v-condominio.firebaseapp.com",
    projectId: "v-condominio",
    storageBucket: "v-condominio.appspot.com",
    messagingSenderId: "830736895964",
    appId: "1:830736895964:web:0ba2287daff4a1048a8919"
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
