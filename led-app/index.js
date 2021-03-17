const express = require('express')
const app = express();
const port = 8080;
const { exec } = require("child_process");
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Hello World!')
});

const steps = 44;

let c_red = -1;
let c_green = -1;
let c_blue = -1; 

function repeatKey(count, key) {
    console.log("Repeating", key, count);
    return new Promise((resolve) => {
        exec(`irsend --count=${count} SEND_ONCE ledall ${key}`, (error, stdout, stderr) => {
            if(error) {
                console.log(error);
            } 
            if(stderr) {
                console.log(stderr);
            }
            console.log(stdout);
            resolve();
        });
    })
}

function sleep(timeout) {
    return new Promise((resolve) => {
        setTimeout(resolve, timeout);
    })
}

async function customColor(red, green, blue) {
    timeout = 150;

    if(c_red == -1 && c_green == -1 && c_blue == -1) {
        newRed = Math.floor(((255 - red) / 255) * steps);
        newGreen = Math.floor(((255 - green) / 255) * steps);
        newBlue = Math.floor(((255 - blue) / 255) * steps);

        await repeatKey(1, "KEY_F7")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(steps, "KEY_F1")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(steps, "KEY_F3")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(steps, "KEY_F5")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(newRed, "KEY_F2")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(newGreen, "KEY_F4")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(newBlue, "KEY_F6")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);  
    } else {
        redDiff = Math.floor(((red - c_red)/ 255) * steps);
        greenDiff = Math.floor(((green - c_green)/ 255) * steps);
        blueDiff = Math.floor(((blue - c_blue)/ 255) * steps);

        await repeatKey(1, "KEY_F7")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(Math.abs(redDiff), redDiff > 0 ? "KEY_F1" : "KEY_F2")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(Math.abs(greenDiff), greenDiff > 0 ? "KEY_F3" : "KEY_F4")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
        await repeatKey(Math.abs(blueDiff), blueDiff > 0 ? "KEY_F5" : "KEY_F6")
        Atomics.wait(new Int32Array(new SharedArrayBuffer(4)), 0, 0, timeout);
    }

    c_red = red;
    c_green = green;
    c_blue = blue;

    return true;
}

app.get('/power', (req, res) => {
    exec(`irsend SEND_ONCE ledall KEY_1`, (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })
    
});

app.get('/auto', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F15", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })
    
});

app.get('/flash', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F16", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })
    
});

app.get('/jump3', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F17", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })
    
});

app.get('/fade3', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F19", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })  
});

app.get('/fade7', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F20", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })
    
});

app.get('/jump7', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_F18", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })  
});

app.get('/red', (req, res) => {
    exec("irsend SEND_ONCE ledall KEY_A", (error, stdout, stderr) => {
        if(error) {
            res.send('Did not work');
            return;
        }
        res.send('Success');
    })  
});

app.post('/color', async (req, res) => {
    const { red, green, blue } = req.body;
    console.log("red", red, "green", green, "blue", blue);
    await customColor(red, green, blue);
    res.send("reply");
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}!`)
});