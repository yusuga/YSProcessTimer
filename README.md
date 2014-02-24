YSProcessTimer
======================
処理時間を計測するための簡易的なタイマー

Log example
----------------

    ==============================
    = UIViewController lifecycle =
    ==============================
    Start     :      0.000000 ( 0.000000) -[ViewController awakeFromNib]
    rap1      :      0.008628 (+0.008628) -[ViewController viewDidLoad]
    rap2      :      0.008682 (+0.000054) -[ViewController viewWillAppear:]
    rap3      :      0.010686 (+0.002004) -[ViewController viewWillLayoutSubviews]
    rap4      :      0.011124 (+0.000438) -[ViewController viewDidLayoutSubviews]
    Stop      :      0.013595 (+0.002471) -[ViewController viewDidAppear:]
    ==============================


License
----------
    Copyright &copy; 2014 Yu Sugawara (https://github.com/yusuga)
    Licensed under the MIT License.

    Permission is hereby granted, free of charge, to any person obtaining a 
    copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.