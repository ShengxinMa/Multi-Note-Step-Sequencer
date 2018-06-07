import processing.sound.*;

SinOsc[] sine; // Array of sines
int numsine = 8; // Number of oscillators to use

int t;

boolean start = false; 

boolean [][] selected;
float [] notes; // Array of frequencies

int cols = 16;
int rows = 8;

int spacing = 50;

void setup()
{
  size(800, 600);
  background(0);
  t = 0;

  selected = new boolean[cols][rows];

  sine = new SinOsc[numsine]; // Initialize the oscillators
  notes = new float[numsine]; // Initialize the notes
  notes[0] = 1047;
  notes[1] = 988;
  notes[2] = 880;
  notes[3] = 784;
  notes[4] = 698;
  notes[5] = 659;
  notes[6] = 587;
  notes[7] = 523;
  
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      selected[i][j] = false;
    }
  }
  // Create the oscillators
  for (int i = 0; i < numsine; i++)
  {
    sine[i] = new SinOsc(this);
  }
  
  //add buttons
  fill(125);
  rect(250, spacing*rows, 90, 90);
  rect(350, spacing*rows, 90, 90);
  rect(450, spacing*rows, 90, 90);
  fill(255);
  textSize(25);
  text("start", 267, spacing*(rows+1));
  text("pause", 360, spacing*(rows+1));
  text("restart", 455, spacing*(rows+1));
}

void draw()
{
  if (start) {
    
    if (0.8*frameCount % cols == 0)
    {
      t = (t + 1) % cols; 
      for (int i = 0; i < numsine; i++)
      {
        sine[i].stop();
      }
      
      for (int i = 0; i < numsine; i++)
      {
        if (selected[t][i]) 
        {
          sine[i].freq(notes[i]);
          sine[i].play();
        }
      }
    }
  }

  // set colours of the board
  for (int i = 0; i < cols; i++)
  {
    for (int j = 0; j < rows; j++)
    {
      if (selected[i][j]) fill(150, 150, 255); 
      else fill(255);
      
      if (i == t) fill(255, 0, 0);

      rect(i*spacing, j*spacing, spacing-10, spacing-10);
    }
  }
}

void mousePressed()
{
  int eyeX = mouseX/spacing;
  int eyeY = mouseY/spacing;
  if (eyeX > -1 && eyeX < cols && eyeY > -1 && eyeY < rows) 
  {
    selected[eyeX][eyeY]=!selected[eyeX][eyeY];
  }
  // set "start" button
  if (mouseX > 250 && mouseX < 340 && mouseY > spacing*rows && mouseY < spacing*(rows+2))
  {
    start = true;
  }
  // set "pause" button
  if (mouseX > 350 && mouseX < 440 && mouseY > spacing*rows && mouseY < spacing*(rows+2))
  {
    start = false;
    for (int i = 0; i < numsine; i++) {
      sine[i].stop();
    }
  }
  // set "restart" button
  if (mouseX > 450 && mouseX < 540 && mouseY > spacing*rows && mouseY < spacing*(rows+2))
  {
    start = false;
    for (int i = 0; i < numsine; i++) 
    {
      sine[i].stop();
    }
    t = 0;
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        selected[i][j]=false;
      }
    }
  }
}