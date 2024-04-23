/* eslint-disable max-len */
const {logger} = require("firebase-functions");
const {onCall} = require("firebase-functions/v2/https");

// The Firebase Admin SDK to access Firestore.
const {initializeApp} = require("firebase-admin/app");
// eslint-disable-next-line max-len
const {getFirestore, Timestamp, FieldValue} = require("firebase-admin/firestore");
const {getAuth} = require("firebase-admin/auth");
const {getStorage} = require("firebase-admin/storage");

initializeApp();
const bucket = getStorage().bucket();

const getPathStorageFromUrl = (url) => {
  const baseUrl = "https://firebasestorage.googleapis.com/v0/b/patrimony-f51f9.appspot.com/o/";
  let imagePath = url.replace(baseUrl, "");
  const indexOfEndPath = imagePath.indexOf("?");
  logger.log("deleteattachment", imagePath);
  imagePath = imagePath.substring(0, indexOfEndPath);
  logger.log("deleteattachment", imagePath);
  imagePath = imagePath.replace("%2F", "/");
  if (imagePath == undefined || imagePath == null || imagePath.trim() == "") {
    imagePath = "aksjbnduiasnl";
  }
  return imagePath;
};

const barcodeHistory = (barcode) => {
  let result = "";
  if (barcode != null && barcode != undefined && barcode.trim() != "") {
    result = `- ${barcode} `;
  }
  return result;
};

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.getcompanies = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyUser = await getFirestore()
        .collection("company_user")
        .where("user_id", "==", userId).get();

    const companiesId = [];
    companyUser.forEach((doc) => {
      companiesId.push(
          {
            company: doc.data().company_id,
            access: doc.data().access_level_id,
          },
      );
    });

    const accessResponse = await getFirestore()
        .collection("access_level")
        .get();

    const access = [];
    accessResponse.forEach((doc) => {
      access.push(doc.data());
    });

    const companyResponse = await getFirestore()
        .collection("companies")
        .where("id", "in", companiesId.map((doc) => doc.company))
        .orderBy("name")
        .get();
    const companies = [];
    companyResponse.forEach((doc) => {
      companies.push(
          {
            id: doc.data().id,
            name: doc.data().name,
            // eslint-disable-next-line max-len
            access: access.filter((access) => access.id == companiesId.filter((it) => it.company == doc.data().id)[0].access),
          },
      );
    });
    logger.log("getCompanies", "Busca de empresas com sucesso");
    return JSON.stringify(companies);
  } else {
    return "";
  }
});

const userlevel = async (companyId, userId) => {
  const userLevel = await getFirestore()
      .collection("company_user")
      .where("company_id", "==", companyId)
      .where("user_id", "==", userId).get();
  logger.log(
      "userlevel", `Nível do usuário: ${userLevel.docs[0].data()["level"]}`);
  return userLevel.docs[0].data()["level"];
};

exports.getusersincompany = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyId = request.data.id;
    const level = await userlevel(companyId, userId);
    if (level == 0 || level == 1) {
      const companyUser = await getFirestore()
          .collection("company_user")
          .where("company_id", "==", companyId)
          .orderBy("level").get();

      const usersId = [];
      companyUser.forEach((doc) => {
        usersId.push({uid: doc.data().user_id});
      });

      const chunkSize = 100;
      const chunksIds = [];
      for (let i = 0; i < usersId.length; i += chunkSize) {
        const chunk = usersId.slice(i, i + chunkSize);
        chunksIds.push(chunk);
      }

      const users = [];
      for (const doc of chunksIds) {
        logger.log("getUsersInCompany", `doc ${doc}`);
        const userResponse = await getAuth()
            .getUsers(Array.isArray(doc) ? doc : [doc]);
        for (const user of userResponse.users) {
          logger.log("getUsersInCompany", `user ${user}`);
          users.push({
            id: user.uid,
            name: user.displayName,
            email: user.email,
            photo_url: user.photoURL,
          });
        }
      }
      logger.log("getUsersInCompany", `length ${users.length}`);
      logger.log(
          "getUsersInCompany", "Busca de usuários da empresa com sucesso");
      return JSON.stringify(users);
    }
    logger.log("getUsersInCompany", `${userId} Nível insuficiente`);
    return "";
  } else {
    return "";
  }
});

exports.getusers = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const userResponse = await getFirestore()
        .collection("users").get();
    const users = [];
    userResponse.forEach((doc) => {
      users.push({
        id: doc.data().id,
        name: doc.data().name,
        email: doc.data().email,
      });
    });
    logger.log("getUsers", "Busca de usuários com sucesso");
    return JSON.stringify(users);
  } else {
    return "";
  }
});

exports.getcategories = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyId = request.data.id;
    const categoriesResponse = await getFirestore()
        .collection("categories")
        .where("company_id", "==", companyId)
        .orderBy("name")
        .get();

    const categories = [];
    categoriesResponse.forEach((doc) => {
      categories.push(
          {
            id: doc.data().id,
            name: doc.data().name,
          });
    });
    logger.log("getCategories", "Busca de categorias com sucesso");
    return JSON.stringify(categories);
  } else {
    return "";
  }
});

exports.getitems = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyId = request.data.companyId;
    const categoryId = request.data.categoryId;
    const itemsResponse = await getFirestore()
        .collection("items")
        .where("company_id", "==", companyId)
        .where("category_id", "==", categoryId)
        .orderBy("name")
        .get();

    const items = [];
    itemsResponse.forEach((doc) => {
      items.push(doc.data());
    });
    logger.log("getItems", "Busca de items com sucesso");
    return JSON.stringify(items);
  } else {
    return "";
  }
});

exports.getitemspaginate = onCall(async (request) => {
  const pageSize = 20;
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyId = request.data.companyId;
    const categoryId = request.data.categoryId;
    const page = request.data.page;
    const itemsResponse = await getFirestore()
        .collection("items")
        .where("company_id", "==", companyId)
        .where("category_id", "==", categoryId)
        .orderBy("name")
        .limit(pageSize)
        .offset(pageSize * (page - 1))
        .get();

    const items = [];
    itemsResponse.forEach((doc) => {
      items.push(doc.data());
    });
    logger.log("getItems", "Busca de items com sucesso");
    return JSON.stringify(items);
  } else {
    return "";
  }
});

exports.gethistoryapp = onCall(async (request) => {
  try {
    const pageSize = 20;
    const userId = request.auth.uid;
    if (userId != null && userId != undefined) {
      const companyId = request.data.id;
      const page = request.data.page;
      const historyResponse = await getFirestore()
          .collection("history")
          .where("company_id", "==", companyId)
          .orderBy("create_at", "desc")
          .limit(pageSize)
          .offset(pageSize * (page - 1))
          .get();

      const history = [];
      historyResponse.forEach((doc) => {
        history.push(doc.data());
      });
      logger.log("gethistory", "Busca de histórico com sucesso");
      return JSON.stringify(history);
    } else {
      return "";
    }
  } catch (e) {
    logger.log("gethistory", `${e}`);
  }
});

exports.postitem = onCall(async (request) => {
  const userId = request.auth.uid;
  const name = request.data.name;
  if (userId != null && userId != undefined && name != null) {
    const companyId = request.data.companyId;
    const categoryId = request.data.categoryId;
    const barcode = request.data.barcode;
    const value = request.data.value;
    const observations = request.data.observations;
    const attachments = request.data.attachments;
    const image = request.data.image;

    try {
      const level = await userlevel(companyId, userId);
      if (level == 0 || level == 1) {
        const ref = getFirestore().collection("items").doc();
        await ref.set({
          id: ref.id,
          company_id: companyId,
          category_id: categoryId,
          name: name,
          code: barcode,
          value: value,
          image: image,
          observations: observations,
          attachments: attachments,
          create_at: Timestamp.now(),
          update_at: Timestamp.now(),
          status: "Na propriedade",
        });
        logger.log("postItem", "Item criado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(categoryId).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: companyId,
          item_id: ref.id,
          title: `${category.data()["name"]}: ${name} ${barcodeHistory(barcode)}criado`,
          email: user.email,
          create_at: Timestamp.now(),
          update_at: Timestamp.now(),
        });
        logger.log("postItem", "Histórico criado");
        return JSON.stringify({success: true});
      }
      logger.log("postItem", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (_) {
      return JSON.stringify({success: false});
    }
  } else {
    return "";
  }
});

exports.postcategory = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const companyId = request.data.companyId;
    const name = request.data.name;

    try {
      const level = await userlevel(companyId, userId);
      if (level == 0 || level == 1) {
        const ref = getFirestore().collection("categories").doc();
        await ref.set({
          id: ref.id,
          company_id: companyId,
          name: name,
          create_at: Timestamp.now(),
          update_at: Timestamp.now(),
        });
        logger.log("postcategory", `Categoria ${name} criada com sucesso`);

        const company = await getFirestore()
            .collection("companies").doc(companyId).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: companyId,
          item_id: ref.id,
          title: `Categoria ${name} criada em ${company.data()["name"]}`,
          email: user.email,
          create_at: Timestamp.now(),
          update_at: Timestamp.now(),
        });
        logger.log("postcategory", "Histórico criado");
        return JSON.stringify({success: true});
      }
      logger.log("postcategory", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (_) {
      return JSON.stringify({success: false});
    }
  } else {
    return "";
  }
});

exports.updatecategory = onCall(async (request) => {
  const userId = request.auth.uid;
  const name = request.data.name;
  if (userId != null && userId != undefined && name != null) {
    const itemId = request.data.id;
    const ref = getFirestore().collection("categories").doc(itemId);
    const item = await ref.get();

    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        await ref.update({
          name: name,
          update_at: Timestamp.now(),
        });
        logger.log("updatecategory", "Categoria atualizada com sucesso");

        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          // eslint-disable-next-line max-len
          title: `Categoria ${item.data()["name"]} foi atualizada para ${name}`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("updatecategory", "Histórico criado");
        return JSON.stringify({success: true});
      }
      logger.log("updatecategory", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("updatecategory", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return "";
  }
});

exports.deleteitem = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const id = request.data.id;
    const ref = getFirestore().collection("items").doc(id);
    const item = await ref.get();
    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        let file = getPathStorageFromUrl(item.data()["image"]);
        bucket.deleteFiles({prefix: file});

        const attachments = item.data()["attachments"];
        if (attachments != null && attachments != undefined && attachments.size > 0) {
          for (let i = 0; i < attachments.length; i++) {
            file = getPathStorageFromUrl(attachments[i]);
            bucket.deleteFiles({prefix: file});
          }
        }

        await ref.delete();
        logger.log("deleteitem", "Item apagado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          title: `${category.data()["name"]}: ${item
              .data()["name"]} ${barcodeHistory(item.data()["barcode"])}deletado`,
          email: user.email,
          create_at: Timestamp.now(),
          update_at: Timestamp.now(),
        });
        logger.log("deleteitem", "Histórico de deleção criado");
        return JSON.stringify({success: true});
      }
      logger.log("deleteitem", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (_) {
      return JSON.stringify({success: false});
    }
  } else {
    return JSON.stringify({success: false});
  }
});

exports.updateitem = onCall(async (request) => {
  const userId = request.auth.uid;
  const name = request.data.name;
  if (userId != null && userId != undefined && name != null) {
    const itemId = request.data.id;
    const barcode = request.data.barcode;
    const value = request.data.value;
    const observations = request.data.observations;
    const status = request.data.status;
    const ref = getFirestore().collection("items").doc(itemId);
    const item = await ref.get();

    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        await ref.update({
          name: name,
          code: barcode,
          value: value,
          observations: observations,
          status: status,
          update_at: Timestamp.now(),
        });
        logger.log("updateitem", "Item atualizado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          // eslint-disable-next-line max-len
          title: `${category.data()["name"]}: ${name} ${barcodeHistory(barcode)}atualizado\n`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("updateitem", "Histórico criado");
        return JSON.stringify({success: true});
      }
      logger.log("updateitem", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("updateitem", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return "";
  }
});

exports.addattachment = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const id = request.data.id;
    const attachment = request.data.attachment;
    const ref = getFirestore().collection("items").doc(id);
    const item = await ref.get();
    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        await ref.update({
          attachments: FieldValue.arrayUnion(attachment),
          update_at: Timestamp.now(),
        });
        logger.log("addattachment", "Item adicionado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          title: `${category.data()["name"]}: ${item
              .data()["name"]} ${barcodeHistory(item.data()["barcode"])}foi adicionado novo arquivo`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("addattachment", "Histórico de addattachment criado");
        return JSON.stringify({success: true});
      }
      logger.log("addattachment", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("deleteattachment", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return JSON.stringify({success: false});
  }
});

exports.deleteattachment = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const id = request.data.id;
    const attachment = request.data.url;
    const ref = getFirestore().collection("items").doc(id);
    const item = await ref.get();
    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        logger.log("deleteattachment", attachment);
        const file = getPathStorageFromUrl(attachment);
        bucket.deleteFiles({prefix: file});
        await ref.update({
          attachments: FieldValue.arrayRemove(attachment),
          update_at: Timestamp.now(),
        });
        logger.log("deleteattachment", "Item apagado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          title: `${category.data()["name"]}: ${item
              .data()["name"]} ${barcodeHistory(item.data()["barcode"])}foi deletado um arquivo`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("deleteattachment", "Histórico de deleteattachment criado");
        return JSON.stringify({success: true});
      }
      logger.log("deleteattachment", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("deleteattachment", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return JSON.stringify({success: false});
  }
});

exports.addphoto = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const id = request.data.id;
    const attachment = request.data.attachment;
    const ref = getFirestore().collection("items").doc(id);
    const item = await ref.get();
    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        const image = item.data()["image"];
        if (image != null && image != undefined && image.trim() != "") {
          const file = getPathStorageFromUrl(attachment);
          bucket.deleteFiles({prefix: file});
        }

        await ref.update({
          image: attachment,
          update_at: Timestamp.now(),
        });
        logger.log("addphoto", "Item adicionado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          title: `${category.data()["name"]}: ${item
              .data()["name"]} ${barcodeHistory(item.data()["barcode"])}foi adicionado nova foto para o item`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("addphoto", "Histórico de addphoto criado");
        return JSON.stringify({success: true});
      }
      logger.log("addphoto", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("deleteattachment", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return JSON.stringify({success: false});
  }
});

exports.deletephoto = onCall(async (request) => {
  const userId = request.auth.uid;
  if (userId != null && userId != undefined) {
    const id = request.data.id;
    const attachment = request.data.url;
    const ref = getFirestore().collection("items").doc(id);
    const item = await ref.get();
    try {
      const level = await userlevel(item.data()["company_id"], userId);
      if (level == 0 || level == 1) {
        const file = getPathStorageFromUrl(attachment);
        bucket.deleteFiles({prefix: file});
        await ref.update({
          image: "",
          update_at: Timestamp.now(),
        });
        logger.log("deleteattachment", "Item apagado com sucesso");

        const category = await getFirestore()
            .collection("categories").doc(item.data()["category_id"]).get();
        const user = await getAuth().getUser(userId);
        const historyRef = getFirestore().collection("history").doc();
        await historyRef.set({
          id: historyRef.id,
          company_id: item.data()["company_id"],
          item_id: ref.id,
          title: `${category.data()["name"]}: ${item
              .data()["name"]} ${barcodeHistory(item.data()["barcode"])}foi deletado a foto`,
          email: user.email,
          create_at: Timestamp.now(),
        });
        logger.log("deleteattachment", "Histórico de deleteattachment criado");
        return JSON.stringify({success: true});
      }
      logger.log("deleteattachment", `${userId} Nível insuficiente`);
      return JSON.stringify({success: false});
    } catch (e) {
      logger.log("deleteattachment", `${e}`);
      return JSON.stringify({success: false});
    }
  } else {
    return JSON.stringify({success: false});
  }
});
