// sound network
SinOsc s => dac;
SqrOsc t => dac;

// only play s
0.5 => s.gain;
0 => t.gain;

fun void newfun( float sgain, float tgain, int forint ){
    
    sgain => s.gain;
    tgain => t.gain; 
    for( 0 => int i; i < forint; i++)
    {
        i => t.freq;
        i*2 => s.freq;
        0.001::second => now;
    }
}

newfun(0.6, 0.2, 500);

//array


//initialize counter variable
0 => int counter;

//infinite loop
while (true)
{
    Math.random2(0, 500) => int nforint;
    newfun(.6,.4,nforint);
    
    counter++;
    <<< "counter", counter >>>;
}
