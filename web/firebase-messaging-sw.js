importScripts('https://www.gstatic.com/firebasejs/10.11.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.11.0/firebase-messaging-compat.js');

firebase.initializeApp(
{
  apiKey: "AIzaSyBGh7sKgESybnN2B-SNfjZt8H3Gc-Rq2no",
  authDomain: "mera-bazaar-17b93.firebaseapp.com",
  projectId: "mera-bazaar-17b93",
  storageBucket: "mera-bazaar-17b93.firebasestorage.app",
  messagingSenderId: "101644876939",
  appId: "1:101644876939:web:d606d307913e7c5ac4e88e",
  measurementId: "G-56KN88BT65"
});

// Initialize Firebase
const messaging = firebase.messaging();