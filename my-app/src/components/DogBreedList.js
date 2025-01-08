// src/components/DogBreedList.js
import React, { useState, useEffect } from 'react';
import axios from 'axios';

const DogBreedList = ({ onSelectBreed }) => {
  const [breeds, setBreeds] = useState([]);

  useEffect(() => {
    const fetchBreeds = async () => {
      try {
        const response = await axios.get('https://dog.ceo/api/breeds/list/all');
        const breedData = response.data.message;
        const breedList = Object.keys(breedData).map((breed) => ({
          breed,
          subBreeds: breedData[breed],
        }));
        setBreeds(breedList);
      } catch (error) {
        console.error('Error fetching breeds:', error);
      }
    };

    fetchBreeds();
  }, []);

  return (
    <div className="breed-list-container">
      <h2>Dog Breeds</h2>
      <ul>
        {breeds.map(({ breed, subBreeds }) => (
          <li key={breed} className="breed-item">
            <span
              onClick={() => onSelectBreed(breed)}
            >
              {breed}
            </span>
            {subBreeds.length > 0 && (
              <ul className="sub-breeds">
                {subBreeds.map((subBreed) => (
                  <li key={subBreed} className="sub-breed-item">
                    <span
                      onClick={() => onSelectBreed(`${breed}/${subBreed}`)}
                    >
                      {subBreed}
                    </span>
                  </li>
                ))}
              </ul>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
};

export default DogBreedList;
