// sound chain
Impulse imp => Delay d => Gain master => dac;

TriOsc s => dac;
.05 => s.gain;

SndBuf kick => master;
SndBuf snare => master;

//variables
0.03::second => dur qrtnote; //each note's duration

//load soundfiles into sndbuf
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/snare_01.wav" => snare.read;

// set all playheads to end so no sound is made
kick.samples() => kick.pos;
snare.samples() => snare.pos;

// synchronize to period
.5::second => dur T;
T - (now % T) => now;

d => d; // feedback loop
0.99 => d.gain; // Exponential decay
0.005::second => d.delay;
1.0 => imp.next;
2.0::second => now;

d => d; // feedback loop
0.99 => d.gain; // Exponential decay
0.05::second => d.delay;
1.0 => imp.next;
2.0::second => now;

//initialize counter variable
0 => int counter;

//infinite loop

while (true)
{
    // beat goes from 0 to 7 (8 positions)
    // 8 positions
    counter % 4 => int beat;
    // snare drum on 2 and 6
        if ((beat == 2) || (beat == 4))
        {
            2 => kick.pos;
            0.05::second => d.delay;
            1.0 => imp.next;
            2.0::second => now;
        }
    
    <<< "counter: ", counter, "Beat:", beat >>>;
    counter++; // counter + 1 => counter
    250::ms => now;
}

