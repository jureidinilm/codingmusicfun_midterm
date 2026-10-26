// sequencer

//variables
0.02::second => dur qrtnote; //each note's duration

// sound chain

Impulse imp => Delay d => Gain master => dac;
d => d;
SndBuf kick => master;
SndBuf hihat => master;
SndBuf snare => master;

// all the rest of the gains are relative to .6
.6 => master.gain;
0.99 => d.gain; // Exponential decay
0.005::second => d.delay; //delay
1.0 => imp.next;

//load soundfiles into sndbuf
me.dir() + "/audio/kick_01.wav" => kick.read;
me.dir() + "/audio/hihat_01.wav"=> hihat.read;
me.dir() + "/audio/snare_01.wav" => snare.read;

// set all playheads to end so no sound is made
kick.samples() => kick.pos;
hihat.samples() => hihat.pos;
snare.samples() => snare.pos;


//initialize counter variable
0 => int counter;

//infinite loop

while (true)
{
    // beat goes from 0 to 7 (8 positions)
    // 8 positions
    counter % 8 => int beat;
    
    if (counter < 9){
        // bass drum on 0 and 4
        if (( beat == 0 ) || (beat == 4))
        {
            0.2 => imp.next;
            qrtnote => now;
        }
        // snare drum on 2 and 6
        if ((beat == 2) || (beat == 6))
        {
            0 => snare.pos;
            Math.random2f(.6,1.4) => snare.rate;
        }
    }
    
    if (counter > 8){
        // bass drum on 0 and 4
        if (( beat == 0 ) || (beat == 4))
        {
            0.2 => imp.next;
            qrtnote => now;
        }
        // snare drum on 2 and 6
        if ((beat == 2) || (beat == 6))
        {
            0 => snare.pos;
            Math.random2f(.3,1.4) => snare.rate;
        }
    }
    
    // it will sound on every beat position
    qrtnote => now;
    
    <<< "counter: ", counter, "Beat:", beat >>>;
    counter++; // counter + 1 => counter
    250::ms => now;
}
