import { funcionario } from './Model/funcionario';
import { endereco } from './Model/endereco';

//console.log("Hello World! Isabella Nascimento");

const enderecoJoao = new endereco('PE', 'Olinda', 'Carmo', 'Rua do Amparo', '321', '50080-090');

const enderecoEduardo = new endereco('PE', 'Recife', 'Boa Vista', 'Rua do Hospicio', '1023', '50080-090');

const joao = new funcionario("123.456.789-00", "João Brayner", "M", new Date("2004-08-26"), "joao.b@gmail.com", 2000);

const eduardo = new funcionario("123.456.789-00", "Eduardo Melo", "M", new Date("1991-12-10"), "eduardo.melo@gmail.com", 3000);

console.log(joao.toString());