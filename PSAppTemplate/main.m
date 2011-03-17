//
//  main.m
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import <UIKit/UIKit.h>
#import <dlfcn.h>
#import <sys/types.h>

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  // !defined(PT_DENY_ATTACH)

int main(int argc, char *argv[]) {
  
  // prevent debugger in AppStore-builds (crack prevention)
#ifdef DEBUG
  //do nothing
#else
  void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
  ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
  ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
  dlclose(handle);
#endif

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}
