Note that local_auth requires the use of a FragmentActivity instead of an Activity. To update your application:
If you are using FlutterActivity directly, change it to FlutterFragmentActivity in your AndroidManifest.xml.

Permissions
Update your project's AndroidManifest.xml file to include the USE_BIOMETRIC permissions:
```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
package="com.example.app">
<uses-permission android:name="android.permission.USE_BIOMETRIC"/>
<manifest>
```
