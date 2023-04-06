importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.17.2/firebase-messaging-compat.js');

const firebaseConfig = {
    apiKey: "AIzaSyBENwkhi_FHpHpnS55c7SHrnFFUt5BfQvk",
    authDomain: "studio-suriano.firebaseapp.com",
    projectId: "studio-suriano",
    storageBucket: "studio-suriano.appspot.com",
    messagingSenderId: "218637504224",
    appId: "1:218637504224:web:c69cf3bcde8f7a51bb8a85"
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
