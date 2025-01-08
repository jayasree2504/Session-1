/// src/components/DogImageModal.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const DogImageModal = ({ breed, onClose }) => {
  const [images, setImages] = useState([]);

  useEffect(() => {
    const fetchDogImages = async () => {
      try {
        const response = await axios.get(
          `https://dog.ceo/api/breeds/image/random/4?breed=${breed}`
        );
        setImages(response.data.message);
      } catch (error) {
        console.error('Error fetching dog images:', error);
      }
    };

    if (breed) {
      fetchDogImages();
    }
  }, [breed]);

  return (
    <div className={`modal ${breed ? 'show' : ''}`}>
      <div className="modal-content">
        <button className="close-btn" onClick={onClose}>Close</button>
        <h3>{breed}</h3>
        <div className="images">
          {images.map((image, index) => (
            <img key={index} src={image} alt={`${breed} ${index}`} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default DogImageModal;
