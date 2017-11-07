**Disclaimer** :<br />
Framework is the created in Objective-C https://github.com/saurabhMendhe/MV/tree/master/MVDownLoadManager.

**MVDownLoadManager: A Download Manager**<br />
MVDownLoadManager is a files download manager built on top of NSURLSession for iOS. 

**Features**<br />
- The same resource(Image/PDF) may be requested by multiple sources simultaneously (even before it has loaded), and if one of the sources cancels the load, it would not affect the remaining requests.
- Different multiple resources may be requested in parallel.
- The Framework is easy to integrate into new iOS project / apps;
- An request to any resources can be cancelled.

**How to use**<br />

- Add the MVDownLoadManager.framework to the xcode project
- Import #import <MVDownLoadManager/MVDownLoadManager.h>
- To start the request use below snippet<br />
          NSURL *url = [NSURL URLWithString:@"https://github.com"];<br />
          [MVDownLoadManager startUrlRequest:url useCache:YES delegate:self];
     
 - Use MVDownLoadManagerDelegate, which can be used to process file after finish downloading or to recieve any error if there is any failure.<br />
    -(void)downloadManagerDidComplete:(NSData *)respondeData;<br />
    -(void)downloadManagerDidFail:(NSError *)error;<br />
    
- In order to cancel the ongoing request, use below snippet<br />
   NSURL *url = [NSURL URLWithString:@"https://github.com"];<br />
   [MVDownLoadManager cancelRequest:url delegate:self];
   
 **Sample App**
The framework is integrated in the sample App, which illustrate the use the MVDownLoadManager framework<br />
https://github.com/saurabhMendhe/MV/tree/master/MVImage.xcodeproj
 

