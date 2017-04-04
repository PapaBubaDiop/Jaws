attribute vec4 Position;
attribute vec2 TexturePosition;

varying vec2 texCoord;


void main(void) {
	gl_Position = Position;
    
    texCoord = TexturePosition;
}
