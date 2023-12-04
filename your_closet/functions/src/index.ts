/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// import {onRequest} from "firebase-functions/v2/https";
// import * as logger from "firebase-functions/logger";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript

// export const getClima = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

import { onRequest } from "firebase-functions/v2/https";
import * as logger from "firebase-functions/logger";
import axios from "axios";
import { Request, Response } from "express";
import express = require("express");

const app = express();

export const getClima = onRequest(app);

app.post("/", async (request: Request, response: Response) => {
  try {
    logger.info("Hello logs!", {structuredData: true});
    // Coordenadas geográficas
    const body = request.body;
    const latitude = body.latitude | -25.09;
    const longitude = body.longitude | -50.16;
    
    // Chave da API OpenWeatherMap
    const apiKey = "0d35b83bdc28ddb58f8d40179272450b";

    // URL da API OpenWeatherMap
    const apiUrl = `https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&lang=pt_br&appid=${apiKey}&units=metric`;

    // Fazendo a chamada para a API usando o axios
    const apiResponse = await axios.get(apiUrl);
    console.log('pegou');
    // Enviando os dados da API como resposta
    response.send(JSON.stringify(apiResponse.data));
  } catch (error) {
    logger.error("Erro ao obter dados climáticos", { error });
    response.status(500).send("Erro ao obter dados climáticos");
  }
});

