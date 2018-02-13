# JavaScriptCore Demo

JavaScriptCore is an open source JavaScript engine that was created and is supported by the WebKit team. It is supported across platforms and has a first party framework provided by Apple for iOS and Mac development.

When doing cross platform development, there are very few options available. JavaScriptCore is an excellent option for code that either doesn't have C and C++ level performance requirements; or that needs to work on the web as well as other platforms.

## This project

Getting started is not necessarily straightforward when working with JavaScriptCore. It also has a few unexpected behaviors that weren't really documented anywhere. The goal of this project is to provide a non-trivial Xcode project, specifically one that performs networking tasks within the JavaScript.

We wanted to explore networking specifically because of the unexpected requirements that JavaScript networking has when run within JavaScriptCore. The short explanation is that anything provided by the browser (i.e. `setInterval` or `fetch`) aren't available within JavaScriptCore. This project provides a basic implementation of both of these.

If you're looking for a more detailed explanation of how to get started, you can view our [blog post here](https://www.lucidchart.com/techblog/?p=5322&preview=true). The post not only explains how to get started, but it also links to several articles that take a deeper dive on some interesting JavaScriptCore related topics.