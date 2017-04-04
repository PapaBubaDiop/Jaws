//
//  OpenGLView.swift
//  iOSSwiftOpenGL
//
//  Created by Bradley Griffith on 6/29/14.
//  Copyright (c) 2014 Bradley Griffith. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import OpenGLES
import GLKit




var ticks = 0

struct Pos {
    var x:GLfloat = 0
    var y:GLfloat = 0
}

//helper extensions to pass arguments to GL land
extension Array {
    func size () -> Int {
        return self.count * MemoryLayout.size(ofValue: self[0])
    }
}

extension Int32 {
    func __conversion() -> GLenum {
        return GLuint(self)
    }
    
    func __conversion() -> GLboolean {
        return GLboolean(UInt8(self))
    }
}

extension Int {
    func __conversion() -> Int32 {
        return Int32(self)
    }
    
    func __conversion() -> GLubyte {
        return GLubyte(self)
    }
    
}



class OpenGLView: UIView {
    
    var eaglLayer: CAEAGLLayer!
    var context: EAGLContext!
    var colorRenderBuffer: GLuint = GLuint()
 //   var indexBuffer: GLuint = GLuint()
 //   var vertexBuffer: GLuint = GLuint()
    var VAO:GLuint = GLuint()
    
    
    var characterTexName: GLuint = GLuint()
    
    
    
    /* Class Methods
    ------------------------------------------*/
    
    override class var layerClass : AnyClass {
        // In order for our view to display OpenGL content, we need to set it's
        //   default layer to be a CAEAGLayer
        return CAEAGLLayer.self
    }
    
    
    /* Lifecycle
    ------------------------------------------*/
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.setupLayer()
        self.setupContext()
        self.setupRenderBuffer()
        self.setupFrameBuffer()
        self.compileShaders()
        self.prepareTexture()
        
  //      self.setupVBOs()
        self.render()
    }
    
    
    
    /* Instance Methods
    ------------------------------------------*/
    
    func setupLayer() {
        // CALayer's are, by default, non-opaque, which is 'bad for performance with OpenGL',
        //   so let's set our CAEAGLLayer layer to be opaque.
        self.eaglLayer	= self.layer as! CAEAGLLayer
        self.eaglLayer.isOpaque = true
    }
    
    func setupContext() {
        
        // Set animation frame rate
   //     view. preferredFramesPerSecond = 60;

        
         let api: EAGLRenderingAPI = EAGLRenderingAPI.openGLES2
        self.context = EAGLContext(api: api)
        let view =  GLKView(frame: self.frame, context: context)
            
        
        if (self.context == nil) {
            print("Failed to initialize OpenGLES 2.0 context!")
            exit(1)
        }
    
        if (!EAGLContext.setCurrent(self.context)) {
            print("Failed to set current OpenGL context!")
            exit(1)
        }
        
        
        view.drawableMultisample = GLKViewDrawableMultisample.multisample4X
    }
    
    func setupRenderBuffer() {
        glGenRenderbuffers(1, &self.colorRenderBuffer)
        glBindRenderbuffer(GLenum(GL_RENDERBUFFER), self.colorRenderBuffer)
        self.context.renderbufferStorage(Int(GL_RENDERBUFFER), from:self.eaglLayer)
    }
    
    func setupFrameBuffer() {
        var frameBuffer: GLuint = GLuint()
        glGenFramebuffers(1, &frameBuffer)
        glBindFramebuffer(GLenum(GL_FRAMEBUFFER), frameBuffer)
        glFramebufferRenderbuffer(GLenum(GL_FRAMEBUFFER), GLenum(GL_COLOR_ATTACHMENT0), GLenum(GL_RENDERBUFFER), self.colorRenderBuffer)
    }
    
    func compileShader(_ shaderName: String, shaderType: GLenum) -> GLuint {
        
        // Get NSString with contents of our shader file.
        let shaderPath: String! = Bundle.main.path(forResource: shaderName, ofType: "glsl")
 //       var error: NSError? = nil
        var shaderString =  try? String(contentsOfFile: shaderPath, encoding: String.Encoding.utf8)
        
        // Tell OpenGL to create an OpenGL object to represent the shader, indicating if it's a vertex or a fragment shader.
        let shaderHandle: GLuint = glCreateShader(shaderType)
        
        if shaderHandle == 0 {
            NSLog("Couldn't create shader")
        }
        
        // Conver shader string to CString and call glShaderSource to give OpenGL the source for the shader.
        let shaderStringUTF8 = shaderString?.cString(using: String.Encoding.utf8)
        
       let l = shaderString?.characters.count
        
        var shaderStringLength: GLint = GLint(l!)
        
        
        var s2 = UnsafePointer(shaderStringUTF8)
 //       glShaderSource(shader: fragmentShader, count: 1, string: &s, length: nil)

        
        glShaderSource(shaderHandle, 1, &s2, &shaderStringLength)
        
        // Tell OpenGL to compile the shader.
        glCompileShader(shaderHandle)
        
        // But compiling can fail! If we have errors in our GLSL code, we can here and output any errors.
        var compileSuccess: GLint = GLint()
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess)
        
        
        var message = [CChar](repeating: CChar(0), count: 256)
        var length = GLsizei(0)
        glGetShaderInfoLog(shaderHandle, 256, &length, &message)
        
        let s = String.init(cString: message)
        
        
  //      print("message = \(s)")
        
        if (compileSuccess == GL_FALSE) {
            print("Failed to compile shader!")
            // TODO: Actually output the error that we can get from the glGetShaderInfoLog function.
            exit(1);
        }
        
        return shaderHandle
    }
    
    func compileShaders() {
        
        // Compile our vertex and fragment shaders.
        let vertexShader: GLuint = self.compileShader("SimpleVertex", shaderType: GLenum(GL_VERTEX_SHADER))
        let fragmentShader: GLuint = self.compileShader("SimpleFragment", shaderType: GLenum(GL_FRAGMENT_SHADER))
        
        // Call glCreateProgram, glAttachShader, and glLinkProgram to link the vertex and fragment shaders into a complete program.
        let programHandle: GLuint  = glCreateProgram()
        glAttachShader(programHandle, vertexShader)
        glAttachShader(programHandle, fragmentShader)
        glLinkProgram(programHandle)
        
        
        
        
       
        
        // Check for any errors.
        var linkSuccess: GLint = GLint()
        glGetProgramiv(programHandle, GLenum(GL_LINK_STATUS), &linkSuccess)
        if (linkSuccess == GL_FALSE) {
            
            
            print("Failed to create shader program!")
            // TODO: Actually output the error that we can get from the glGetProgramInfoLog function.
            exit(1);
        }
        
        // Call glUseProgram to tell OpenGL to actually use this program when given vertex info.
        glUseProgram(programHandle)
        
        // Finally, call glGetAttribLocation to get a pointer to the input values for the vertex shader, so we
        //  can set them in code. Also call glEnableVertexAttribArray to enable use of these arrays (they are disabled by default).
  //      self.positionSlot = GLuint(glGetAttribLocation(programHandle, "Position"))
  //      self.textureSlot = GLuint(glGetAttribLocation(programHandle, "TexturePosition"))
  //      glEnableVertexAttribArray(self.positionSlot)
  //      glEnableVertexAttribArray(self.textureSlot)
 
        
        glBindAttribLocation(programHandle, 0, "Position")
        glBindAttribLocation(programHandle, 1, "TexturePosition")
        glEnableVertexAttribArray(0)
        glEnableVertexAttribArray(1)
        
        
        
        
        glUseProgram(programHandle)
        let samplerLoc: GLint = glGetUniformLocation(programHandle, "sampler")
        
        // Indicate that the diffuse texture will be bound to texture unit 0
        let unit:GLint = 0
        glUniform1i(samplerLoc, unit)
        
        
        var logLen:GLint = GLint()
        glGetProgramiv(programHandle, GLenum(GL_INFO_LOG_LENGTH), &logLen);
        if(logLen > 0) {
            print("Prog Info Log: \(logLen)")
        }

        
    }
    
    // Setup Vertex Buffer Objects
    func setupVBOs() {
/*
        glGenVertexArraysOES(1, &VAO);
        glBindVertexArrayOES(VAO);
        
        glGenBuffers(1, &vertexBuffer)
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), vertexBuffer)
        glBufferData(GLenum(GL_ARRAY_BUFFER), Vertices.size(), Vertices, GLenum(GL_STATIC_DRAW))
        
//        let positionSlotFirstComponent : UnsafePointer<Int>(&0)
        glEnableVertexAttribArray(positionSlot)
        glVertexAttribPointer(positionSlot, 3, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(MemoryLayout<Vertex>.size), nil)
        
        glEnableVertexAttribArray(textureSlot)
//        let colorSlotFirstComponent = UnsafePointer<Int>(sizeof(Float) * 3)
        glVertexAttribPointer(textureSlot, 2, GLenum(GL_FLOAT), GLboolean(UInt8(GL_FALSE)), GLsizei(MemoryLayout<Vertex>.size), nil)
        
        glGenBuffers(1, &indexBuffer)
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), indexBuffer)
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), Indices.size(), Indices, GLenum(GL_STATIC_DRAW))
        
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), 0)
        glBindVertexArrayOES(0)
*/
    }
    
    
    func prepareTexture()
    {
        let image = UIImage(named:"g_5.png")
        characterTexName = buildTexture(image!)
        
    }
    
    
    func buildTexture(_ image:UIImage)->GLuint
    {
        var texName:GLuint = GLuint()
        
        // Create a texture object to apply to model
        glGenTextures(1, &texName);
        glBindTexture(GLenum(GL_TEXTURE_2D), texName);
        
        // Set up filter and wrap modes for this texture object
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_S), GL_CLAMP_TO_EDGE);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_WRAP_T), GL_CLAMP_TO_EDGE);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GL_LINEAR);
        glTexParameteri(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GL_LINEAR_MIPMAP_LINEAR);
        
        // Indicate that pixel rows are tightly packed
        //  (defaults to stride of 4 which is kind of only good for
        //  RGBA or FLOAT data types)
        glPixelStorei(GLenum(GL_UNPACK_ALIGNMENT), 1);
        
        // Allocate and load image data into texture
        
        let imageRef = image.cgImage
  
        
        let w:Int = (imageRef?.width)!
        let h:Int = (imageRef?.height)!
        let w4 = w * 4
        let space = imageRef!.colorSpace
        
   //     print("color space = \(space)")
        
        let data = calloc(1, w4 * h)
        
        let bitmapInfo = CGBitmapInfo(rawValue:  CGImageAlphaInfo.premultipliedLast.rawValue)
        
        
        
        // Create context in order to render image on memory spaces
        let context = CGContext(data: data, width: w, height: h, bitsPerComponent: 8, bytesPerRow: w4, space: space!, bitmapInfo: bitmapInfo.rawValue)
        
        let rect2 = CGRect(x: 0, y: 0, width: CGFloat(w), height: CGFloat(h))
        
  //      let context = CGContext(data: data, width: w, height: h, bitsPerComponent: 8, bytesPerRow: w*4, space: imageRef!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
        
        
        
        context?.draw(imageRef!, in: rect2)
   
/*
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, 8,
                                            bitmapBytesPerRow, colorSpace, bitmapInfo.rawValue)
        
        // draw the image onto the context
        let rect = CGRect(x: 0, y: 0, width: pixelsWide, height: pixelsHigh)
        CGContextDrawImage(context, rect, img)
*/
        
        
        // Generate a texture
        glGenTextures(1, &texName)
        // Bind a texture
        glBindTexture(GLenum(GL_TEXTURE_2D), texName)
        
        //
        glTexParameterf(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MAG_FILTER), GLfloat(GL_LINEAR))
        glTexParameterf(GLenum(GL_TEXTURE_2D), GLenum(GL_TEXTURE_MIN_FILTER), GLfloat(GL_LINEAR))
        
        // Populate memories as texture
        glTexImage2D(GLenum(GL_TEXTURE_2D), 0, GLint(GL_RGBA), GLsizei(w), GLsizei(h), 0, GLenum(GL_RGBA), GLenum(GL_UNSIGNED_BYTE), data)
        
        return texName
    }

    
    func render() {
        var positions = [Pos]()
        var texCoords = [Pos]()
        let app = UIApplication.shared.delegate as! AppDelegate
 
        
        
 //       setupVBOs()
 //       glBindVertexArrayOES(VAO)
        glViewport(0, 0, GLint(self.frame.size.width), GLint(self.frame.size.height))
        
        let w:GLfloat = GLfloat(self.frame.size.width)/2
        let h:GLfloat = GLfloat(self.frame.size.height)/2
        
  //       print("width = \(w)    height = \(h)")
        glEnable(GLenum(GL_TEXTURE_2D))
        
  //      glActiveTexture(GLenum(GL_TEXTURE0))
        
        
        
        
        // Bind the texture to be used
        glBindTexture(GLenum(GL_TEXTURE_2D), characterTexName)
        
        glEnable(GLenum(GL_BLEND))

        
        glClearColor(1.0, 1.0, 1.0, 1.0)
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
  
        
 //       glDrawElements(GLenum(GL_TRIANGLES), GLsizei(Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)

//        glDrawElements(GLenum(GL_LINES), GLsizei(Indices.count), GLenum(GL_UNSIGNED_BYTE), nil)

        for t in app.obj.hulls  {
            let tc = t.color
            if tc>0 {
            positions.removeAll()
            texCoords.removeAll()
            var clr: GLfloat = 0.9 - GLfloat(tc) * 0.125
            var x0:GLfloat = 0
            var y0:GLfloat = 0
            var k = 0
            
            
            for p in t.vtx {
                
                let x:GLfloat = (GLfloat(p.x)-w)/w
                let y:GLfloat = (h-GLfloat(p.y))/h
                x0 += x
                y0 += y
                k += 1
                
                texCoords.append(Pos(x:0.5, y:clr))
                positions.append(Pos(x:x, y:y))
                
            }
            let p0 = positions.first
            positions.insert(p0!, at: 0)
            
            x0 = x0/GLfloat(k)
            y0 = y0/GLfloat(k)
            
            positions.insert(Pos(x:x0, y:y0), at: 0)
  
            texCoords.append(Pos(x:0.5, y:clr))
            texCoords.append(Pos(x:0.5, y:clr))
            
            
            glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, positions)
            glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, texCoords)
            glDrawArrays(GLenum(GL_TRIANGLE_FAN), 0, k + 2)
            }
        }
        
 
        
        
        
        for t in app.obj.hulls  {
                positions.removeAll()
                texCoords.removeAll()
                let clr: GLfloat = 0.1
                var k = 0
                for p in t.vtx {
                    let x:GLfloat = (GLfloat(p.x)-w)/w
                    let y:GLfloat = (h-GLfloat(p.y))/h
                    k += 1
                    
                    texCoords.append(Pos(x:0.5, y:clr))
                    positions.append(Pos(x:x, y:y))
                    
                }
                let p0 = positions.first
                positions.insert(p0!, at: 0)
                texCoords.append(Pos(x:0.5, y:clr))
                
                
                glVertexAttribPointer(0, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, positions)
                glVertexAttribPointer(1, 2, GLenum(GL_FLOAT), GLboolean(GL_FALSE), 0, texCoords)
                glDrawArrays(GLenum(GL_LINE_LOOP), 0, k + 1)
        }
        
        
        
        
        
        
        self.context.presentRenderbuffer(Int(GL_RENDERBUFFER))
        
 //       glBindVertexArrayOES(0)
    }
}

///////////////////////////////////////

