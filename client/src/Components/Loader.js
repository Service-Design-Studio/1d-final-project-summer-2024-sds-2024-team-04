import React from 'react'
import Lottie from 'react-lottie'
import * as animationData from '../assets/annimations/loader.json'


export default function Loader() {
    
    const defaultOptions = {
        loop: true,
        autoplay: true,
        animationData: animationData,
    }
  return (
    <Lottie options={defaultOptions} height={100} width={100} />
  )
}