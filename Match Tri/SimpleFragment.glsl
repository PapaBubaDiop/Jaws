precision highp float;


uniform sampler2D sampler;
varying vec2 texCoord;   // Uses default highp precision.

void main()
{
    gl_FragColor = texture2D(sampler, texCoord);
}

