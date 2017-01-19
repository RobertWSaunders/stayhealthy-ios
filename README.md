# StayHealthy Fitness
Website: [http://www.stayhealthy.io/](http://www.stayhealthy.io/)

StayHealthy is an easy to use fitness aid for both iOS devices. It puts hundreds of workouts and exercises right in the palm of your hand. Create your own workouts, or search for premade workouts specific to sports. Recover faster and stay injury free with a large catalog of stretching and warmup exercises. You can even favourite the exercises and workouts you love! For easy access, users have the ability to sync their data across all of their devices. Never be without your workout routine again!

<img src="/img/Screenshot1.png" height="390">
<img src="/img/Screenshot2.png" height="390">
<img src="/img/Screenshot3.png" height="390">
<img src="/img/Screenshot4.png" height="390">

## Personal

For a long time, I have been self-conscious of my body and wanted to create an application that would help me and other people in a similar situation become less self-conscious. So, I began to write StayHealthy Fitness using Objective-C. I had prior experience writing iOS applications in Objective-C but StayHealthy is particularly special to me. StayHealthy is designed using the model view controller design pattern and relies on Core Data to store the user’s data and a SQLite database to store the exercises and workouts. Internally, I implemented a singleton class that acts as the controller to all the models which individually represent a Core Data entity. To display exercise and workout images I utilized multiple different threads to load them asynchronously to make the user interface transition between views better. StayHealthy is something I am very proud of and it challenged me immensely at times, see the final product [here.](http://www.stayhealthy.io/)

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## License

Copyright 2017 Robert Saunders

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
